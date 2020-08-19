
path = require 'path'
fs = require 'fs'
pkg = require './src/index'

file = 'example/cirru/index.cirru'

cat = (x) -> fs.readFileSync x, "utf8"

env = if process.env.env is 'release' then 'release' else 'dev'

assets =
  switch env
    when 'dev'
      "/main.js"
    when 'release'
      assetsJson = require './dist/assets'
      assetsJson.main.js

data =
  '@filename': file
  js: assets

console.log "assets", data

pkg.setResolver (basePath, child, scope) ->
  dest = path.join (path.dirname basePath), child
  scope?['@filename'] = dest
  cat dest

if env is 'dev'
  fs.writeFileSync 'index.html', (pkg.render (cat file), data)
  console.log 'Wrote to index.html'
else
  fs.writeFileSync 'dist/index.html', (pkg.render (cat file), data)
  console.log 'Wrote to dist/index.html'

