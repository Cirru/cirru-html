
{renderer} = require './index'

req = new XMLHttpRequest
req.open 'GET', 'cirru/methods.cirru'
req.send()
req.onload = ->
  render = renderer req.responseText, {}
  html = render a: 1, b: 2, add: (x, y) -> x + y
  document.querySelector('#entry').innerHTML = html