
Cirru HTML
------

...converts Cirru to HTML.

Demo http://repo.tiye.me/cirru-html/

### Usage

```
npm install --save cirru-html
```
```
{convert} = require 'cirru-htlm'
code = 'span (= cirru code)'
html = convert code
# '<span>cirru code</span>'
```

### Demo

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
IfExpression
RepeatExpression &key, &value
WithExpression
InsertExpression
PartialExpression
BlockExpression
DefineExpression
MethodsExpression
```