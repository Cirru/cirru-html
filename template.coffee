
path = require 'path'
{cat} = require 'shelljs'
pkg = require './src/index'

file = 'example/cirru/index.cirru'

data =
  '@filename': file

pkg.setResolver (basePath, child, scope) ->
  dest = path.join (path.dirname basePath), child
  scope?['@filename'] = dest
  cat dest

(pkg.render (cat file), data).to 'index.html'

console.log 'done: cirru'
