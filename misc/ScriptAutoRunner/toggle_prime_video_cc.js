// Title: Toggle subtitle on Amazon Prime Video
// Hostname: amazon.co.jp

let count = 0

document.addEventListener('keydown', (event) => {
  if (event.key === 'ContextMenu') {
    count++

    if (count % 2 === 0) {
      document.querySelector('#subtitles_fll_main_container').style.opacity = '1'
      document.querySelector('.fk87jrb').style.opacity = '1'
    }
    else {
      document.querySelector('#subtitles_fll_main_container').style.opacity = '0'
      document.querySelector('.fk87jrb').style.opacity = '0'
    }

    document.activeElement.blur()
  }
})
