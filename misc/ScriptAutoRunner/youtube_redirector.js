// Title: YouTube Redirector
// Hostname: youtube.com

YOUTUBE_HOST = 'https://www.youtube.com'
YOUTUBE_ALTERNATIVE_HOST = 'https://www.youtube-nocookie.com'

function main() {
  isFailed().then((status) => {
    if (status) {
      location.href = getAvailableURL(getID())
    }
  })
}

async function isFailed() {
  try {
    await fetch(YOUTUBE_HOST)
    return false
  }
  catch {
    return true
  }
}

function getID() {
  return new URLSearchParams(location.search).get('v')
}

function getAvailableURL(id) {
  return `${YOUTUBE_ALTERNATIVE_HOST}/embed/${id}`
}

main()
