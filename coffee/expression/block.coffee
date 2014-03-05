
abstract = require '../abstract'

exports.Expression = class
  constructor: (tree) ->
    @args = tree[1..]

    @cachedInnerHTML = undefined

    @children = []

    @readArgs()

  readArgs: ->
    for item in @args
      if typeof item is 'string'
        @children.push item
      else
        @children.push (abstract.makeAbstract item)

  cache: (data) ->
    shoudCache = yes
    for item in @children
      if typeof item isnt 'string'
        shoudCache = shoudCache and item.cache data
    if shoudCache
      @cachedInnerHTML = @render data
    shoudCache

  render: (data) ->
    if @cachedInnerHTML?
      return @cachedInnerHTML
      
    buffer = ''
    for item in @children
      if typeof item is 'string'
        buffer += item
      else
        buffer += item.render data
    buffer