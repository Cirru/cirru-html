
require 'shelljs/make'
fs = require 'fs'

target.dev = ->
  station = require 'devtools-reloader-station'
  station.start()

  recompile = (name) ->
    exec "coffee -o src/ -bc #{name}", ->
      exec 'browserify -o build/build.js -d src/demo.js', ->
        station.reload 'repo/cirru/html'

  fs.watch './coffee', interval: 200, (type, name) ->
    recompile "coffee/#{name}"
  fs.watch './coffee/expression', interval: 200, (type, name) ->
    recompile "coffee/expression/#{name}"
  fs.watch './coffee/tag', interval: 200, (type, name) ->
    recompile "coffee/tag/#{name}"

pkg = require './coffee/index'

target.test_at = ->
  testFile = 'cirru/at.cirru'
  render = pkg.renderer (cat testFile)
  html = render demo: 'DEMO', nothing: 'NOTHING'
  html.to 'compiled/at.html'
  console.log 'wrote: compiled/at.html'

target.test_block = ->
  testFile = 'cirru/block.cirru'
  render = pkg.renderer (cat testFile)
  html = render switcher: yes, noswitcher: no
  html.to 'compiled/block.html'
  console.log 'wrote: compiled/block.html'

target.test_html = ->
  testFile = 'cirru/html.cirru'
  render = pkg.renderer (cat testFile)
  html = render()
  html.to 'compiled/html.html'
  console.log 'wrote: compiled/html.html'

target.test_if = ->
  testFile = 'cirru/if.cirru'
  render = pkg.renderer (cat testFile)
  html = render switcher: yes
  html.to 'compiled/if.html'
  console.log 'wrote: compiled/if.html'

target.test_insert = ->
  testFile = 'cirru/insert.cirru'
  render = pkg.renderer (cat testFile), '@filename': testFile
  html = render()
  html.to 'compiled/insert.html'
  console.log 'wrote: compiled/insert.html'

target.test_methods = ->
  testFile = 'cirru/methods.cirru'
  render = pkg.renderer (cat testFile)
  html = render a: 1, b: 2, add: (x, y) -> x + y
  html.to 'compiled/methods.html'
  console.log 'wrote: compiled/methods.html'

target.test_partial = ->
  testFile = 'cirru/partial.cirru'
  render = pkg.renderer (cat testFile), '@filename': testFile
  html = render demo: 'demo text', nothing: 'e..'
  html.to "compiled/partial.html"
  console.log 'wrote: compiled/partial.html'

target.test_repeat = ->
  testFile = 'cirru/repeat.cirru'
  render = pkg.renderer (cat testFile)
  html = render list: ['a', 'b', 'c', 'd']
  html.to "compiled/repeat.html"
  console.log 'wrote: compiled/repeat.html'

target.test_with = ->
  testFile = 'cirru/with.cirru'
  render = pkg.renderer (cat testFile), '@filename': testFile
  html = render datas: {a: 'A', b: 'B'}
  html.to "compiled/with.html"
  console.log 'wrote: compiled/with.html'

target.test_special = ->
  testFile = 'cirru/special.cirru'
  render = pkg.renderer (cat testFile)
  html = render()
  html.to "compiled/special.html"
  console.log 'wrote: compiled/special.html'

target.test = ->
  target.test_at()
  target.test_block()
  target.test_html()
  target.test_if()
  target.test_insert()
  target.test_methods()
  target.test_partial()
  target.test_repeat()
  target.test_with()
  target.test_special()