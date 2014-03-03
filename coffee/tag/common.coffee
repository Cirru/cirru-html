
{makeAbstract} = require '../abstract'

exports.CommonTag = class CommonTag
  constructor: (tree) ->
    @func = tree[0]
    @args = tree[1..]

    @lazyAttrs = no
    @cachedAttrs = undefined
    @cachedInnerHTML = undefined

    @tagName = 'div'
    @attrs =
      id: undefined
      classes: []
    @children = []

  readFunc: ->
    matchTag = @func.match /^[\w-]+/
    if matchTag?
      @tagName = matchTag[0]

    matchId = @func.match /\#([\w-]+)/
    if matchId?
      @attrs.id = matchId[1]

    matchClasses = @func.match /\.([\w-]+)/g
    if matchClasses?
      for item in matchClasses
        @addClass item[1..]

  addClass: (name) ->
    unless name in @attrs.classes
      @attrs.classes.push name

  readArgs: ->
    for item in @args
      func = item[0]
      arg = item[1]
      matchAttr = item.match /^:([\w-]+)/
      if matchAttr?
        attr =  matchAttr[1]
        if typeof arg is 'string'
          value = arg
        else if Array.isArray arg
          @lazyAttrs = yes
          value = makeAbstract arg
        else throw new Error "(#{arg}) is strange"
        if attr is 'id'
          @attr.id = value
        else if attr is 'class'
          @addClass value

  renderAttrs: (data) ->
    buffer = []
    for key, value of @attrs
      if typeof value is 'string'
        buffer.push "#{key}=\"#{value}\""
      else
        result = value.render()
        buffer.push "#{key}='#{result}'"
    buffer.join(' ')

  cache: (data) ->
    unless @lazyAttrs
      @cachedAttrs = @renderAttrs data
    shouldCache = yes
    for item in @children
      shouldCache = shouldCache and item.cache data
    if shouldCache
      @cachedInnerHTML = @renderInnerHTML data
    if @cachedAttrs? and @cachedInnerHTML?
      @render data
    shouldCache