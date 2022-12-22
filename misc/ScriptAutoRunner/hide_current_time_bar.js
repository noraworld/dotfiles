// WIP: It doesn't work properly

// Title: Hide current time bar
// Hostname: calendar.google.com

const currentTimeBarElements = ['.H3tRZe', '.h11RHc']

let count = 0
document.addEventListener('keydown', (event) => {
  if (event.key === 'ContextMenu' || event.key === 'c') {
    count++

    if (count % 2 === 0) {
      show()
    }
    else {
      hide()
    }
  }
})

function show() {
  for (element of currentTimeBarElements) {
    document.querySelector(element).style.opacity = 1
  }
}

function hide() {
  for (element of currentTimeBarElements) {
    document.querySelector(element).style.opacity = 0
  }
}

hide()
