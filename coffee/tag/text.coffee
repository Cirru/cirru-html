
abstract = require '../abstract'

exports.Tag = class
  constructor: (tree) ->
    @args = tree[1..]
    @children = []

    @cachedInnerHTML = undefined

    @readArgs()

  readArgs: ->
    for item in @args
      if typeof item is 'string'
        @children.push item
      else
        @children.push (abstract.makeAbstract item)

  render: (data) ->
    if @cachedInnerHTML?
      return @cachedInnerHTML
    buffer = []
    for item in @children
      if typeof item is 'string'
        buffer.push item
      else
        buffer.push (item.render data)
    buffer.join(' ')

  cache: (data) ->
    shouldCache = yes
    for item in @children
      if typeof item isnt 'string'
        cacheOfChild = item.cache data
        shouldCache = shouldCache and cacheOfChild
    if shouldCache
      @cachedInnerHTML = @render data
    shouldCache