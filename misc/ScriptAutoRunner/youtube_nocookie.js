// Title: YouTube Embed Replacer
// Hostname: All (no need to specify)

// Replace "www.youtube.com" with "www.youtube-nocookie.com" in iframe sources
for (frame of document.querySelectorAll('iframe')) {
  if (frame.src) {
    if (extractDomain(frame.src) === 'www.youtube.com') {
      frame.src = frame.src.replace('www.youtube.com', 'www.youtube-nocookie.com')
    }
  }
}

// https://stackoverflow.com/questions/8498592/extract-hostname-name-from-string
function extractDomain(url) {
  const a = document.createElement('a')
  a.href = url
  return a.hostname
}
