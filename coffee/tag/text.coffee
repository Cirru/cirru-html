
{makeAbstract} = require '../abstract'

exports.TextTag = class TextTag
  constructor: (tree) ->
    @args = tree[1..]

  render: (data) ->
    if @cachedInnerHTML?
      return @cachedInnerHTML
    buffer = []
    for item in @args
      if typeof item is 'string'
        buffer.push item
      else
        buffer.push (makeAbstract item).render()
    buffer.join(' ')

  cache: (data) ->
    shouldCache = yes
    for item in @args
      shouldCache = shouldCache and item.cache data
    if shouldCache
      @cachedInnerHTML = @render data
    shouldCache