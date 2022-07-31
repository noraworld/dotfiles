// Title: Toggle subtitle on Netflix
// Hostname: netflix.com

let count = 0

document.addEventListener('keydown', (event) => {
  if (event.key === 'ContextMenu') {
    count++

    if (count % 2 === 0) {
      document.querySelector('#lln-subs-content').style.opacity = '1'
    }
    else {
      document.querySelector('#lln-subs-content').style.opacity = '0'
    }

    document.activeElement.blur()
  }
})
