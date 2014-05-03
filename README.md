
Cirru HTML
------

A template engine that converts Cirru to HTML.

See demos on http://repo.cirru.org/html

### Usage

```
npm install --save cirru-html
```
```
{makeRender, render, setResolver} = require 'cirru-html'
code = 'span (= cirru code)'
data = {}

renderer = makeRender code, {}
renderer {} # pass in data # => '<span>cirru code</span>'

render code, data # => '<span>cirru code</span>'
```

* `makeRender`

`template` is a code string in Cirru,
or a JSON Object of parsed Cirru code (with `cirruParser.pare`).

`renderer` is a cached renderer that make it fast.
`data` is optional.

In Node, you need `data['@filename']` to run `@insert` and `@partial`.

* `render`

Shorthand for using `renderer` in one call:

```coffee
exports.render = (template, data) ->
  render = exports.makeRender template, data
  render data
```

* `setResolver`

Solution for reading file is taken out from module it self

```coffee
html = require 'cirru-html'
html.setResolver (basePath, child, scope) ->
  dest = path.join (path.dirname basePath), child
  scope?['@filename'] = dest
  html = fs.readFileSync dest, 'utf8'
```

```coffee
setResolver (basePath, child, scope) ->
  match = child.match /(\w+)\.cirru/
  element = q "##{match[1]} .file"
  element.value or element.innerHTML
```

### Demo of HTML

Here's a demo of HTML:

```cirru
doctype

html
  html
    title $ = "Cirru HTML"
    meta $ :charset utf-8
    link (:rel stylesheet) $ :href css/style.css
    script (:defer) $ :src build/build.js
  body
    #entry
    @repeat (@ names)
      .test
        :id (@ @value)
        textarea.file
        textarea.data
        button.button ->
        textarea.result
```

*Notice:* the compiled HTML is not prettified.

### Template engine

```
@
@if
@block
@repeat
@with
@insert
@partial
```

Functions may also be passed into the renderer to apply on the data.

### Architeture

Steps of rendering:

```
Cirru Code
  -> Syntax Tree
    -> Abstract Syntax Tree, based on Classes
      -> Cached Tree, HTML data converted
        -> Rendering
```

Classes for rendering HTML:

```
SingleTag
PairTag
TextTag
```

Classes for expressions

```
AtExpression
IfExpression
RepeatExpression &key, &value
WithExpression
InsertExpression
PartialExpression
BlockExpression
MethodsExpression
```

Filenames passed to `@insert` and `@partial` are only names.

`data` parameters contain at least `@filename` and `@methods: []`.

### Changelog

* Since `0.2`, `renderer` is removed

### License

MIT