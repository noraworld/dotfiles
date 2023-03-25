// Title: YouTube Current Tab
// Hostname: youtube-nocookie.com

function main() {
  document.addEventListener('click', openInCurrentTab)

  // Hidden overlay container when paused
  document.querySelector('.ytp-pause-overlay-container').hidden = true
}

function openInCurrentTab() {
  document.querySelectorAll('a').forEach((element) => {
    if (element.getAttribute('target') === '_blank') {
      element.removeAttribute('target')
    }
  })
}

main()
