#!/usr/bin/env coffee
project = 'repo/cirru/html'

require 'shelljs/make'
path = require 'path'
mission = require 'mission'
fs = require 'fs'
{pare} = require 'cirru-parser'

mission.time()

pkg = require './coffee/index'
pkg.setResolver (basePath, child, scope) ->
  dest = path.join (path.dirname basePath), child
  scope?['@filename'] = dest
  cat dest

target.coffee = ->
  mission.coffee
    find: /\.coffee$/, from: 'coffee/', to: 'js/', extname: '.js'
    options:
      bare: yes

cirru = ->
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

  (pkg.render (cat file), data).to 'index.html'
  console.log 'done: cirru'

browserify = (callback) ->
  mission.browserify
    file: 'main.js', from: 'js/', to: 'build/', done: callback

target.cirru = -> cirru()
target.browserify = -> browserify()

target.compile = ->
  cirru()
  target.coffee yes
  browserify()

target.watch = ->
  station = mission.reload()

  mission.watch
    files: ['cirru/', 'coffee/']
    trigger: (filepath, extname) ->
      switch extname
        when '.cirru'
          cirru()
          station.reload project
        when '.coffee'
          filepath = path.relative 'coffee/', filepath
          mission.coffee
            file: filepath, from: 'coffee/', to: 'js/', extname: '.js'
            options:
              bare: yes
          browserify ->
            station.reload project

target.patch = ->
  target.compile()
  mission.bump
    file: 'package.json'
    options:
      at: 'patch'

target.sync = ->
  mission.rsync
    file: './'
    options:
      dest: 'tiye:~/repo/topics.tiye.me/'
      exclude: [
        'node_modules/'
        'README.md'
        'coffee'
        'js'
      ]

test = (name) ->
  testFile = "cirru/#{name}.cirru"
  js = cat "compiled/data/#{name}.js"
  data = eval "(#{js})"
  data?['@filename'] = testFile
  html = pkg.render (pare cat testFile), data
  wanted = cat "compiled/#{name}.html"
  if html.trimRight() is wanted.trimRight()
    console.log 'ok!', name
  else
    console.log '------'
    console.log 'failed!', name
    console.log html

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