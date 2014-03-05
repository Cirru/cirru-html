
Cirru HTML
------

converts Cirru to HTML like a template engine.

Poor demo http://repo.tiye.me/cirru-html/

It has not been documented yet.
Read `cirru/` to see what Cirru-HTML can do.

### Usage

```
npm install --save cirru-html
```
```
{renderer} = require 'cirru-html'
code = 'span (= cirru code)'
render = renderer code, {} # pass in initial data
render {} # pass in data
# '<span>cirru code</span>'
```

### Only HTML

```cirru
meta (:charset utf-8)
div (:class demo-a demo-b)
  = demo of text
  :data root node
  span $ = nothing
  = plain text
#entry.demo (:class c)
div.demo
div#demo $ = content
.class-a
```

Converts to (this module doesn't do prettify things yet):

```html
<meta charset="utf-8">
<div class="demo-a demo-b" data="root node">demo of text
  <span>nothing</span>plain text</div>
<div id="entry" class="c demo"></div>
<div class="demo"></div>
<div id="demo">content</div>
<div class="class-a"></div>
```

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