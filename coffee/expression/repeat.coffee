
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
    buffer = ''
    array = @variable.render data
    unless Arrai.isArray array
      throw new Error "(#{variable}) supposed to be an array"
    for index, value in array
      scope =
        __proto__: data
        '@key': index
        '@value': value

      for item in @children
        @buffer += item.render scope
    buffer