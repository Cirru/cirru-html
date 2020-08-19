
abstract = require '../abstract'

exports.Tag = class CommonTag
  constructor: (tree) ->
    @func = tree[0]
    @args = tree[1..]

    @lazyAttrs = no
    @cachedAttrs = undefined
    @cachedInnerHTML = undefined

    @tagName = 'div'
    @attrs =
      id: undefined
      class: []

    @children = []

    @readFunc()
    @readArgs()

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
    unless name in @attrs.class
      @attrs.class.push name

  readArgs: ->
    for item in @args
      if typeof item is 'string'
        @children.push render: (-> item), cache: (-> yes)
        continue

      func = item[0]
      if not func?
        console.error 'args:', @args, 'func:', @func
        throw new Error("Empty in args")
      matchAttr = func.match /^:([\w-]+)/
      if matchAttr?
        prop = item[1..]
        attr = matchAttr[1]

        if prop.length is 0
          value = 'true'
        else if typeof prop[0] is 'string'
          value = prop.join(' ')
        else if Array.isArray prop[0]
          @lazyAttrs = yes
          prop = prop[0]
          value = abstract.makeAbstract prop
        else throw new Error "(#{prop}) is strange"

        if attr is 'id'
          @attrs.id = value
        else if attr is 'class'
          @addClass value
        else
          @attrs[attr] = value
      else
        @children.push (abstract.makeAbstract item)

  renderAttrs: (data) ->
    buffer = []
    delete @attrs.class if @attrs.class?.length is 0
    delete @attrs.id if @attrs.id is ''
    for key, value of @attrs
      if typeof value is 'string'
        buffer.push "#{key}=\"#{value}\""
      else if Array.isArray value
        props = []
        for item in value
          if typeof item is 'string'
            props.push item
          else
            props.push item.render(data)
        buffer.push "#{key}=\"#{props.join(' ')}\""
      else if typeof value is 'object'
        result = value.render data
        buffer.push "#{key}=\"#{result}\""
    buffer.join(' ')

  cache: (data) ->
    unless @lazyAttrs
      @cachedAttrs = @renderAttrs data
    shouldCache = yes
    for item in @children
      cacheOfChild = item.cache data
      shouldCache = shouldCache and cacheOfChild
    if shouldCache
      @cachedInnerHTML = @renderInnerHTML data
    if @cachedAttrs? and @cachedInnerHTML?
      @render data
    shouldCache