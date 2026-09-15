-- codex://threads/01a04c9a-81e0-7831-86d7-26fdd78b3d7c

local GRAYSCALE_SCHEDULE = {
  -- Use hours for specific hours, or fromHour/toHour for an inclusive range.
  -- Use everyMinutes for regular intervals, or minutes = { 0, 15, 45 } for exact minutes.
  { hours = { 0 }, everyMinutes = 10 },
  { fromHour = 1, toHour = 7, everyMinutes = 5 },
  { fromHour = 10, toHour = 19, everyMinutes = 30 },
  { hours = { 22 }, everyMinutes = 20 },
  { hours = { 23 }, everyMinutes = 15 },
}
-- local DEBUG_ALERT_SECONDS = 4
-- local DEBUG_LOG_PATH = os.getenv("HOME") .. "/.hammerspoon/grayscale-debug.log"

local grayscaleTimer = nil
local wakeWatcher = nil
local nextRunAt = 0
local enableGrayscaleIfNeeded = nil
local scheduledMinutes = nil

local function appendDebugLog(message)
  -- local line = os.date("%Y-%m-%d %H:%M:%S") .. " " .. message .. "\n"
  -- local file = io.open(DEBUG_LOG_PATH, "a")
  -- if file then
  --   file:write(line)
  --   file:close()
  -- end
end

local function showDebug(message)
  -- appendDebugLog(message)
  -- hs.alert.show(message, nil, nil, DEBUG_ALERT_SECONDS)
end

local function colorFiltersState()
  local output = hs.execute("/usr/bin/defaults read com.apple.mediaaccessibility __Color__-MADisplayFilterCategoryEnabled 2>/dev/null", true)
  local trimmed = tostring(output):match("^%s*(.-)%s*$") or ""

  if trimmed == "1" then
    return true, trimmed
  end

  return false, trimmed
end

local function pressAccessibilityShortcut()
  local ok, result = hs.osascript.applescript([[
tell application "System Events"
  key code 96 using {command down, option down}
end tell
]])

  if not ok then
    showDebug("grayscale: System Events key failed: " .. tostring(result))
  end
end

local function addScheduledMinute(minutesByDay, hour, minute)
  if hour < 0 or hour > 23 or minute < 0 or minute > 59 then
    showDebug("grayscale: ignored invalid schedule time " .. tostring(hour) .. ":" .. tostring(minute))
    return
  end

  minutesByDay[hour * 60 + minute] = true
end

local function addScheduleEntry(minutesByDay, entry)
  local hours = entry.hours
  if not hours then
    hours = {}
    for hour = entry.fromHour, entry.toHour do
      table.insert(hours, hour)
    end
  end

  for _, hour in ipairs(hours) do
    if entry.minutes then
      for _, minute in ipairs(entry.minutes) do
        addScheduledMinute(minutesByDay, hour, minute)
      end
    else
      for minute = 0, 59, entry.everyMinutes do
        addScheduledMinute(minutesByDay, hour, minute)
      end
    end
  end
end

local function scheduledMinutesOfDay()
  if scheduledMinutes then
    return scheduledMinutes
  end

  local minutesByDay = {}
  for _, entry in ipairs(GRAYSCALE_SCHEDULE) do
    addScheduleEntry(minutesByDay, entry)
  end

  scheduledMinutes = {}
  for minuteOfDay in pairs(minutesByDay) do
    table.insert(scheduledMinutes, minuteOfDay)
  end
  table.sort(scheduledMinutes)

  return scheduledMinutes
end

local function nextScheduledRunAt(afterTime)
  local schedule = scheduledMinutesOfDay()
  if #schedule == 0 then
    return nil
  end

  local now = os.date("*t", afterTime)
  local todayStart = os.time({
    year = now.year,
    month = now.month,
    day = now.day,
    hour = 0,
    min = 0,
    sec = 0,
  })
  local afterMinuteOfDay = now.hour * 60 + now.min

  for _, minuteOfDay in ipairs(schedule) do
    local runAt = todayStart + minuteOfDay * 60
    if minuteOfDay > afterMinuteOfDay or (minuteOfDay == afterMinuteOfDay and now.sec < 1) then
      if runAt > afterTime then
        return runAt
      end
    end
  end

  return todayStart + 24 * 60 * 60 + schedule[1] * 60
end

local function scheduleNextRun()
  if grayscaleTimer then
    grayscaleTimer:stop()
  end

  nextRunAt = nextScheduledRunAt(os.time())
  if not nextRunAt then
    showDebug("grayscale: no scheduled times")
    return
  end

  grayscaleTimer = hs.timer.doAt(os.date("%H:%M", nextRunAt), "1d", function()
    enableGrayscaleIfNeeded()
    scheduleNextRun()
  end)
end

enableGrayscaleIfNeeded = function()
  local now = os.time()
  if nextRunAt > 0 and now < nextRunAt then
    showDebug("grayscale: skipped until " .. os.date("%H:%M", nextRunAt))
    return
  end

  local enabled, rawState = colorFiltersState()
  if enabled then
    showDebug("grayscale: already on, state=" .. rawState)
  else
    showDebug("grayscale: off, sending System Events Option+Command+F5, state=" .. rawState)
    pressAccessibilityShortcut()
    hs.timer.doAfter(1, function()
      local afterEnabled, afterRawState = colorFiltersState()
      showDebug("grayscale: after shortcut enabled=" .. tostring(afterEnabled) .. ", state=" .. afterRawState)
    end)
  end
end

wakeWatcher = hs.caffeinate.watcher.new(function(eventType)
  if eventType == hs.caffeinate.watcher.systemDidWake then
    enableGrayscaleIfNeeded()
    scheduleNextRun()
  end
end)

wakeWatcher:start()
scheduleNextRun()
