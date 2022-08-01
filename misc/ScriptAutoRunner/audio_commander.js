// Title: Audio Commander
// Hostname: any

document.addEventListener('keydown', (event) => {
  let index = 0
  let audio = document.querySelectorAll('audio')[index]

  switch (event.key) {
    case 'z':
      index++
      audio = document.querySelectorAll('audio')[index]
      break
    case ' ':
    case 'Enter':
      if (audio.paused) {
        audio.play()
      }
      else {
        audio.pause()
      }
      break
    case 'a':
      audio.currentTime -= 2
      break
    case 's':
      audio.currentTime += 2
      break
    case '0':
      audio.currentTime = 0
      break
  }
})
