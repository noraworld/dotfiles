// Title: Toggle subtitle on watch.pokemon.com
// Hostname: watch.pokemon.com

let count = 0

document.addEventListener('keydown', (event) => {
  if (event.key === 'c') {
    count++

    if (count % 2 === 0) {
      document.querySelector('.vjs-menu-item.vjs-subtitles-menu-item').previousElementSibling.click()
    }
    else {
      document.querySelector('.vjs-menu-item.vjs-subtitles-menu-item').click()
    }

    document.activeElement.blur()
  }
})
