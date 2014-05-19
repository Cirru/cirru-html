
abstract = require '../abstract'

exports.Expression = class
  constructor: (tree) ->
    @variable = tree[1]
    @args = tree[2..]

    @children = []

    @readArgs()

  readArgs: ->
    @variable = abstract.makeAbstract @variable
    for item in @args
      @children.push (abstract.makeAbstract item)

  cache: (data) ->
    for item in @children
      item.cache data
    no

  render: (data) ->
    array = @variable.render data
    unless Array.isArray array
      throw new Error "(#{variable}) supposed to be an array"
    buffer = ''
    for value, key in array
      scope = {}
      scope['@key'] = key + 1
      scope['@value'] = value

      for k, v of data
        unless scope[k]?
          scope[k] = v

      if key is 0 then scope['@first'] = yes
      if key is (array.length - 1) then scope['@last'] = yes

      for item in @children
        buffer += item.render scope

    buffer