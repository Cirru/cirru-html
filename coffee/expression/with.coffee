
{makeAbstract} = require '../abstract'
{evaluate} = require '../evaluate'

exports.WithExpression = classWithtExpression
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
    obj = evaluate data, @variable
    unless typeof obj is 'object'
      throw new Error "(#{variable}) supposed to be an object"
    for key, value in array
      scope =
        __proto__: data
        '@key': key
        '@value': value

      for item in @children
        @buffer += item.render scope
    buffer