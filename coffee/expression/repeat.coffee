
{makeAbstract} = require '../abstract'
{evaluate} = require '../evaluate'

exports.RepeatExpression = class RepeatExpression
  constructor: (tree) ->
    @variable = tree[1]
    @args = tree[2..]

    @children = []

    @readArgs()

  readArgs: ->
    for item in @args
      @children.push (makeAbstract item)

  cache: (data) ->
    for item in @children
      item.cache data
    no

  render: (data) ->
    buffer = ''
    array = evaluate data, @variable
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