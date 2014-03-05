
{renderer} = require './index'

req = new XMLHttpRequest
req.open 'GET', 'cirru/tmpl.cirru'
req.send()
req.onload = ->
  render = renderer req.responseText, {}
  html = render req.responseText
  document.querySelector('#entry').innerHTML = html