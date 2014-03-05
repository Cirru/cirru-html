
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
    console.log 'array is', array
    unless Array.isArray array
      throw new Error "(#{variable}) supposed to be an array"
    buffer = ''
    for value, key in array
      scope =
        __proto__: data
        '@key': (key + 1)
        '@value': value

      if key is 0 then scope['@first'] = yes
      if key is (array.length - 1) then scope['@last'] = yes

      for item in @children
        buffer += item.render scope

    buffer