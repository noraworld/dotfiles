// Title: Modifier Keys Prevention
// Hostname: github.com, zenhub.com

window.addEventListener('keydown', function(event) {
  if (
    (event.ctrlKey && event.code === 'Enter')                   ||
    (event.metaKey && event.shiftKey && event.code === 'Enter')
  ) {
    event.preventDefault()
    event.stopImmediatePropagation()
  }
}, true)
