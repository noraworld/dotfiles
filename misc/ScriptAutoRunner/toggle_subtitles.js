// Title: Toggle subtitle
// Hostname: netflix.com, youtube.com, amazon.co.jp



const DEEPL_API_KEY = 'YOUR_API_KEY'
const DEEPL_API_URL = 'https://api-free.deepl.com/v2/translate'

// Try to disable subtitles several times.
// This might not take effect for only one trial in case the subtitles aren't ready yet.
let actualTrialCount = 0
function tryToDisableSubtitle(expectedTrialCount = 5, interval = 1000) {
  subtitle(false, false)
  actualTrialCount++

  // Remove Language Reactor error message automatically
  let llnNotification = document.querySelector('.lln-notification')
  if (llnNotification) {
    llnNotification.remove()
  }

  if (actualTrialCount >= expectedTrialCount) {
    actualTrialCount = 0
    return
  }

  setTimeout(tryToDisableSubtitle, interval)
}
tryToDisableSubtitle()

function enforcePause(interval = 5000) {
  llnToggle = document.querySelector('.lln-toggle')
  if (llnToggle && llnToggle.checked === false) {
    llnToggle.click()
  }

  setTimeout(enforcePause, interval)
}
enforcePause()

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
let repeatCount = 0
window.addEventListener('keydown', (event) => {
  if ((event.key === 'c') && isAvailable(event)) {
    if (document.querySelector('#lln-subs-content').style.opacity === '0') {
      subtitle(true)
    }
    else {
      subtitle(false)
    }

    document.activeElement.blur()
    event.stopPropagation()
  }
  else if ((event.key === ' ' || event.key === 'Enter') && isAvailable(event)) {
    document.querySelector('.lln-repeat-sub-btn').click()
    event.stopPropagation()
  }
  // else if ((event.key === '[') && isAvailable(event)) {
  //   document.querySelector('.lln-toggle').click()
  //   event.stopPropagation()
  // }
  else if ((event.key === 'ArrowUp') && isAvailable(event)) {
    subtitle(false, notified = false)

    if (document.querySelector('video').paused) {
      document.querySelector('video').play();
    }
    else {
      document.querySelector('video').pause();
    }

    event.stopPropagation()
  }
  else if ((event.key === 'ArrowDown') && isAvailable(event)) {
    if ((repeatCount % 2) === 0) {
      popup('ON (rep)')

      document.querySelector('video').onpause = function() {
        setTimeout(() => {
          document.querySelector('.lln-repeat-sub-btn').click()
        }, 1000)
      }

      document.querySelector('.lln-repeat-sub-btn').click()
      event.stopPropagation()
    }
    else {
      popup('OFF (rep)')

      document.querySelector('video').onpause = function() {
        event.stopPropagation()
      }
    }

    event.stopPropagation()
    repeatCount++
  }
}, true)

// Turn on or off subtitles.
function subtitle(flag, notified = true) {
  const visibility = flag ? '1' : '0'
  const message = flag ? 'ON (sub)' : 'OFF (sub)'

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
  if (flag) {
    document.querySelector('.lln-sub-menu-btn').click()
    translate(document.querySelector('.lln-copy-text').getAttribute('data-text-to-copy'))
    document.querySelector('.lln-sub-menu-btn').click()
  }
}

// https://qiita.com/yaju/items/bf4613393cd4ee402d17#javascript
function translate(text, encoded = true) {
  if (encoded) {
    var content = 'auth_key=' + DEEPL_API_KEY + '&text=' + text + '&source_lang=EN&target_lang=JA'
  }
  else {
    var content = encodeURI('auth_key=' + DEEPL_API_KEY + '&text=' + text + '&source_lang=EN&target_lang=JA')
  }
  let url = DEEPL_API_URL + '?' + content

  fetch(url)
    .then(function(response) {
      if (response.ok) {
        return response.json()
      } else {
        console.error('Could not reach the API: ' + response.statusText)
      }
    }).then(function(data) {
      console.log(data["translations"][0]["text"])
      document.querySelector('.lln-sentence-wrap').insertAdjacentHTML(
        'afterend',
        `<p style="margin: 0; text-shadow: rgb(0, 0, 0) 0px 0px 7px, rgba(0, 0, 0, 0.8) 0px 0px 18px; /* font-weight: 700; */">${data["translations"][0]["text"]}</p>`
      )
    }).catch(function(error) {
      console.error(error.message)
      document.querySelector('.lln-sentence-wrap').insertAdjacentHTML(
        'afterend',
        `<p style="margin: 0; text-shadow: rgb(0, 0, 0) 0px 0px 7px, rgba(0, 0, 0, 0.8) 0px 0px 18px; /* font-weight: 700; */">${error.message}</p>`
      )
    })
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
  }, 400)
}

function isAvailable(event) {
  if ((document.activeElement.nodeName             === 'INPUT'
    &&   document.activeElement.getAttribute('type') !== 'range')
    ||   document.activeElement.nodeName             === 'TEXTAREA'
    ||   document.activeElement.getAttribute('type') === 'text'
    ||   document.activeElement.isContentEditable    === true
    ||   (event.metaKey || event.ctrlKey || event.altKey))
    {
      return false
    }
    else {
      return true
    }
}
