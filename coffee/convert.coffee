
singleTags = 'area base br col command embed hr'
singleTags+= ' img input keygen link meta param source track wbr'
singleTags = singleTags.split ' '

cirru = require 'cirru-parser'

isArray = (x) -> Array.isArray x
isString = (x) -> typeof x is 'string'

regTag = /^\w[\w-_\d]*/
regId = /#\w[\w-_\d]*/
regClass = /\.\w[\w-_\d]*/g

short = (x) -> x[1..]

readEach = (exp) ->
  if exp.length is 0
    throw new Error "Empty expression not allowed"
  [name, args...] = exp
  unless isString name
    throw new Error "{{ #{name} }} should be a name"
  info =
    name: name
    tag: 'div'
    id: null
    class: []
    attrs: {}
    child: []
  args.forEach (arg) ->
    if (isArray arg) and arg.length > 0
      action = arg[0]
      content = arg[1..].join ' '

      if action is '='
        info.child.push content
      else if action is ':class'
        info.class.push content
      else if action is ':id'
        info.id = content.replace /\s/g, '-'
      else if action[0] is ':'
        attr = action[1..]
        info.attrs[attr] = content
      else
        info.child.push (readEach arg)

  tagName = info.name.match regTag
  if tagName then info.tag = tagName[0]
  tagId = info.name.match regId
  if tagId? then info.id = tagId[0][1..]
  tagClass = info.name.match regClass
  if tagClass? then info.class.push (tagClass.map short)...
  console.log 'tagClass', tagClass

  html  = "<#{info.tag}"
  if info.id?
    html += " id=\"#{info.id}\""
  if info.class.length > 0
    console.log 'class', info.class
    html += " class=\"#{info.class.join ' '}\""
  for key, value of info.attrs
    html += " #{key}=\"#{value}\""

  if info.tag in singleTags
    html += '/>'
  else
    html += '>'
    for child in info.child
      html += child
    html += "</#{info.tag}>"
  html


exports.convert = (code) ->
  ast = cirru.parseShort code

  (ast.map readEach).join ''