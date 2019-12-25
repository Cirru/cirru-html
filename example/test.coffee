
path = require 'path'

pkg = require '../src/index'

{cat} = require 'shelljs'
{pare} = require 'cirru-parser'

pkg.setResolver (basePath, child, scope) ->
  dest = path.join (path.dirname basePath), child
  scope?['@filename'] = dest
  cat dest

test = (name) ->
  testFile = "example/cirru/#{name}.cirru"
  js = cat "example/data/#{name}.js"
  data = eval "(#{js})"
  data?['@filename'] = testFile
  html = pkg.render (pare cat testFile), data
  wanted = cat "example/generated/#{name}.html"
  if html.trimRight() is wanted.trimRight()
    console.log 'ok!', name
  else
    console.log '------'
    console.log 'failed!', name
    console.log html

test 'at'
test 'block'
test 'if'
test 'html'
test 'methods'
test 'repeat'
test 'special'
test 'with'
test 'insert'
test 'partial'