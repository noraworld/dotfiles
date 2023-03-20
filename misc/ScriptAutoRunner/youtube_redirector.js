// Title: YouTube Redirector
// Hostname: youtube.com

YOUTUBE_HOST = 'www.youtube.com'
YOUTUBE_ALTERNATIVE_HOST = 'www.youtube-nocookie.com'

function main() {
  isFailed().then((status) => {
    const id = getID()
    if (status && location.host === YOUTUBE_HOST && id) {
      location.href = getAvailableURL(id)
    }
  })
}

async function isFailed() {
  try {
    await fetch(`https://${YOUTUBE_HOST}`)
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
  return `https://${YOUTUBE_ALTERNATIVE_HOST}/embed/${id}`
}

main()
