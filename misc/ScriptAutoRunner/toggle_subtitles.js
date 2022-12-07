// Title: Toggle subtitle
// Hostname: netflix.com, youtube.com, amazon.co.jp



// Try to disable subtitles several times.
// This might not take effect for only one trial in case the subtitles aren't ready yet.
let actualTrialCount = 0
function tryToDisableSubtitle(expectedTrialCount = 5, interval = 1000) {
  subtitle(false, false)
  actualTrialCount++

  if (actualTrialCount >= expectedTrialCount) {
    actualTrialCount = 0
    return
  }

  setTimeout(tryToDisableSubtitle, interval)
}
tryToDisableSubtitle()

// Disable subtitles when a URL is changed.
// They're on by default. You might want to conceal them at first because they might be spoilers.
let href = location.href
let observer = new MutationObserver(function() {
  if (href !== location.href) {
    tryToDisableSubtitle()
    href = location.href
  }
})
observer.observe(document, { childList: true, subtree: true })

// Toggle subtitles.
let count = 0
document.addEventListener('keydown', (event) => {
  if (event.key === 'ContextMenu') {
    count++

    if (count % 2 === 0) {
      subtitle(false)
    }
    else {
      subtitle(true)
    }

    document.activeElement.blur()
  }
})

// Turn on or off subtitles.
function subtitle(flag, notified = true) {
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
      if (notified) alert(error)
    }
  }
  else if (document.domain.match(/amazon.co.jp$/)) {
    try {
      document.querySelector('.fk87jrb').style.opacity = visibility
    }
    catch (error) {
      console.error(error)
      if (notified) alert(error)
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

  if (notified) popup(message)
}

// Pop up the message that states whether subtitles are now on or off.
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
