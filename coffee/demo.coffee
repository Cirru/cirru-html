
{convert} = require './convert'

req = new XMLHttpRequest
req.open 'GET', 'cirru/html.cirru'
req.send()
req.onload = ->
  html = convert req.responseText
  document.querySelector('#entry').innerHTML = html