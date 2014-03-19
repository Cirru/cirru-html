
fs = require 'fs'
{parseShort} = require 'cirru-parser'
{join, dirname} = require 'path'

abstract = require '../abstract'

exports.Expression = class
  constructor: (tree) ->
    @partialPath = tree[1]
    @filename = undefined

    @children = []

    @cachedInnerHTML = undefined

  loadTemplate: (name) ->
    unless typeof @partialPath is 'string'
      throw new Error "(#{partialPath}) should be a static filename"
    syntaxTree = parseShort (fs.readFileSync name, 'utf8')
    for item in syntaxTree
      @children.push (abstract.makeAbstract item)

  cache: (data) ->
    filename = join (dirname data['@filename']), @partialPath
    scope =
      __proto__: data
      '@filename': filename
    @loadTemplate filename

    shouldCache = on
    for item in @children
      cacheOfChild = item.cache data
      shouldCache = shouldCache and cacheOfChild
    if shouldCache
      @cachedInnerHTML = @render data
    no

  render: (data) ->
    return @cachedInnerHTML if @cachedInnerHTML?
    buffer = ''
    for item in @children
      buffer += item.render data
    buffer