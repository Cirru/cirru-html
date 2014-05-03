
{pare} = require 'cirru-parser'

abstract = require '../abstract'

exports.Expression = class
  constructor: (tree) ->
    @partialPath = tree[1]
    @filename = undefined

    @children = []

    @cachedInnerHTML = undefined

  resolve: ->
    throw new Error 'use .setResolver to add solver'

  cache: (data) ->

    unless typeof @partialPath is 'string'
      throw new Error "(#{partialPath}) should be a static filename"

    scope =
      __proto__: data
      '@filename': undefined # will be rerwitten in resolver

    code = @resolve data['@filename'], @partialPath, scope
    syntaxTree = pare code
    for item in syntaxTree
      @children.push (abstract.makeAbstract item)

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