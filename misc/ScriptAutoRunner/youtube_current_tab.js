// Title: YouTube Current Tab
// Hostname: youtube-nocookie.com

function main() {
  document.addEventListener('click', openInCurrentTab)
}

function openInCurrentTab() {
  document.querySelectorAll('a').forEach((element) => {
    if (element.getAttribute('target') === '_blank') {
      element.removeAttribute('target')
    }
  })
}

main()
