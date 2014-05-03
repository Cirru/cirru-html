#!/usr/bin/env coffee

project = 'repo/cirru/html'
interval = interval: 300
watch = no

require 'shelljs/make'
fs = require 'fs'
path = require 'path'
station = require 'devtools-reloader-station'
browserify = require 'browserify'
exorcist = require 'exorcist'

{makeRender, render} = require './coffee/index'
{pare} = require 'cirru-parser'

pkg = require './coffee/index'
pkg.setResolver (basePath, child, scope) ->
  dest = path.join (path.dirname basePath), child
  scope?['@filename'] = dest
  html = fs.readFileSync dest, 'utf8'

startTime = (new Date).getTime()
process.on 'exit', ->
  now = (new Date).getTime()
  duration = (now - startTime) / 1000
  console.log "\nfinished in #{duration}s"

reload = -> station.reload project if watch

compileCoffee = (name, callback) ->
  exec "coffee -o js/ -bc coffee/#{name}", ->
    console.log "done: coffee, compiled coffee/#{name}"
    do callback

packJS = ->
  bundle = browserify ['./js/main']
  .bundle debug: yes
  bundle.pipe (exorcist 'build/build.js.map')
  .pipe (fs.createWriteStream 'build/build.js', 'utf8')
  bundle.on 'end', ->
    console.log 'done: browserify'
    do reload

target.cirru = ->
  file = 'cirru/index.cirru'
  data =
    '@filename': file
    names: [
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

  (render (cat file), data).to 'index.html'
  console.log 'done: cirru'
  do reload

target.js = ->
  exec 'coffee -o js/ -bc coffee/'

target.compile = ->
  target.cirru()
  exec 'coffee -o js/ -bc coffee/', ->
    packJS()

target.watch = ->
  watch = yes
  fs.watch 'cirru/', interval, target.cirru
  fs.watch 'coffee/', interval, (type, name) ->
    if type is 'change'
      compileCoffee name, ->
        do packJS

  station.start()


test = (name) ->
  testFile = "cirru/#{name}.cirru"
  js = cat "compiled/data/#{name}.js"
  data = eval "(#{js})"
  data?['@filename'] = testFile
  html = pkg.render (pare cat testFile), data
  html.to "compiled/#{name}.html"
  console.log "done: compiled/#{name}.html"

target.run = ->
  test 'at', demo: 'DEMO', nothing: 'NOTHING'

target.test = ->
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