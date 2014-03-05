
{renderer} = require './index'

req = new XMLHttpRequest
req.open 'GET', 'cirru/if.cirru'
req.send()
req.onload = ->
  render = renderer req.responseText, {}
  code = req.responseText
  html = render switcher: yes
  document.querySelector('#entry').innerHTML = html