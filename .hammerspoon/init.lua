-- codex://threads/01a04c9a-81e0-7831-86d7-26fdd78b3d7c

local RUN_EVERY_MINUTES = 30
local RUN_EVERY_SECONDS = RUN_EVERY_MINUTES * 60
-- local DEBUG_ALERT_SECONDS = 4
-- local DEBUG_LOG_PATH = os.getenv("HOME") .. "/.hammerspoon/grayscale-debug.log"

local grayscaleTimer = nil
local wakeWatcher = nil
local nextRunAt = 0
local enableGrayscaleIfNeeded = nil

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

local function nextCronRunAt(afterTime)
  return (math.floor(afterTime / RUN_EVERY_SECONDS) + 1) * RUN_EVERY_SECONDS
end

local function scheduleNextRun()
  if grayscaleTimer then
    grayscaleTimer:stop()
  end

  nextRunAt = nextCronRunAt(os.time())
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
