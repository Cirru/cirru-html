
{makeRender, setResolver, render} = require './index'

names = [
  'at'
  'block'
  'html'
  'if'
  'insert'
  'methods'
  'partial'
  'repeat'
  'special'
  'with'
]

q = (query) -> document.querySelector query
get = (url, callback) ->
  req = new XMLHttpRequest
  req.open 'GET', url
  req.send()
  req.onload = ->
    callback req.responseText

setResolver (basePath, child, scope) ->
  match = child.match /(\w+)\.cirru/
  element = q "##{match[1]} .file"
  element.value or element.innerText

names.forEach (name) ->
  get "cirru/#{name}.cirru", (text) ->
    q("##{name} .file").innerText = text

    get "compiled/data/#{name}.js", (text) ->
      q("##{name} .data").innerText = text

      q("##{name} .button").click()

document.body.onclick = (event) ->
  if event.target.className is 'button'
    name = event.target.parentElement.id
    file = q("##{name} .file").innerText
    data = q("##{name} .data").innerText
    html = render file, (eval "(#{data})")
    q("##{name} .result").innerText = html