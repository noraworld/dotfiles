// Title: Toggle subtitle
// Hostname: netflix.com, youtube.com, amazon.co.jp

let count = 0

document.addEventListener('keydown', (event) => {
  if (event.key === 'ContextMenu') {
    count++

    if (count % 2 === 0) {
      subtitle(true)
    }
    else {
      subtitle(false)
    }

    document.activeElement.blur()
  }
})

function subtitle(flag) {
  const visibility = flag ? '1' : '0'
  const message = flag ? 'ON' : 'OFF'

  if (document.domain.match(/netflix.com$/) || document.domain.match(/youtube.com$/)) {
    try {
      // Language Reactor is necessary on Netflix and YouTube
      //   https://chrome.google.com/webstore/detail/hoombieeljmmljlkjmnheibnpciblicm
      document.querySelector('#lln-subs-content').style.opacity = visibility
    }
    catch (error) {
      console.error(error)
      alert(error)
    }
  }
  else if (document.domain.match(/amazon.co.jp$/)) {
    try {
      document.querySelector('.fk87jrb').style.opacity = visibility
    }
    catch (error) {
      console.error(error)
      alert(error)
    }

    try {
      // The error will occur when Subtitles for Language Learning (Prime Video) is off
      //   https://chrome.google.com/webstore/detail/hlofmmmlhfelbfhcpapoackkglljfcnb
      document.querySelector('#subtitles_fll_main_container').style.opacity = visibility
    }
    catch (error) {
      console.error(error)
    }
  }

  popup(message)
}

function popup(message) {
  let body = document.querySelector('body')
  let popupElement = document.createElement('div')

  popupElement.style.width = `${window.innerWidth}px`
  popupElement.style.height = `${window.innerHeight}px`
  popupElement.style.top = '0px'
  popupElement.style.left = '0px'
  popupElement.style.position = 'fixed'
  popupElement.style.display = 'flex'
  popupElement.style.alignItems = 'center'
  popupElement.style.justifyContent = 'center'
  popupElement.style.fontSize = '100px'
  popupElement.style.backgroundColor = 'rgba(0, 0, 0, 0.7)'
  popupElement.style.color = 'rgb(255, 255, 255)'
  popupElement.style.zIndex = '1000000'
  popupElement.innerHTML = message
  body.appendChild(popupElement)

  setTimeout(() => {
    body.removeChild(popupElement)
  }, 250)
}
