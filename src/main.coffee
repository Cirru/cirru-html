
{makeRender, setResolver, render} = require './index'

require '../css/style.css'

setResolver (basePath, child, scope) ->
  match = child.match /(\w+)\.cirru/
  element = document.querySelector "##{match[1]} .file"
  element.value or element.innerText

document.body.onclick = (event) ->
  if event.target.className is 'button'
    parent = event.target.parentElement
    file = parent.querySelector('.file').value
    data = parent.querySelector('.data').value
    try
      html = render file, (eval "(#{data})")
      parent.querySelector('.result').value = html
    catch err
      parent.querySelector('.result').value = err.stack

buttons = document.querySelectorAll('.button')
for button in buttons
  button.click()