
require 'shelljs/make'

target.dev = ->
  exec 'pkill -f doodle', ->
    exec 'doodle log:yes index.html cirru/ build/build.js', async: yes
  exec 'coffee -o src/ -wbc coffee', async: yes
  exec 'watchify -o build/build.js -d src/demo.js -v', async: yes

target.test = ->
  pkg = require './coffee/index'
  testFile = 'cirru/partial.cirru'
  render = pkg.renderer (cat testFile), '@filename': testFile
  html = render demo: 'demo text', nothing: 'e..'
  console.log html