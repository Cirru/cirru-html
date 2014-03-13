
require 'shelljs/make'
fs = require 'fs'

station = require 'devtools-reloader-station'

station.start()

recompile = (name) ->
  exec "coffee -o src/ -bc #{name}", ->
    exec 'browserify -o build/build.js -d src/demo.js', ->
      station.reload 'repo/cirru/html'

target.dev = ->
  fs.watch './coffee', interval: 200, (type, name) ->
    recompile "coffee/#{name}"
  fs.watch './coffee/expression', interval: 200, (type, name) ->
    recompile "coffee/expression/#{name}"
  fs.watch './coffee/tag', interval: 200, (type, name) ->
    recompile "coffee/tag/#{name}"

target.test = ->
  pkg = require './coffee/index'
  testFile = 'cirru/partial.cirru'
  render = pkg.renderer (cat testFile), '@filename': testFile
  html = render demo: 'demo text', nothing: 'e..'
  console.log html