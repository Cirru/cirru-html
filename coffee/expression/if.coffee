
{makeAbstract} = require '../abstract'
{evaluate} = require '../evaluate'

exports.IfExpression = class IfExpression
  constructor: (tree) ->
    @args = tree[1..]

    @cachedInnerHTML = undefined

    @condition = undefined
    @trueExpression = undefined
    @falseExpression = undefined

    @readArgs()

  readArgs: ->
    @condition = args[0]
    @trueExpression = makeAbstract args[1]
    @falseExpression = makeAbstract args[2] if args[2]?

  cache: (data) ->
    @trueExpression.cache data
    if @falseExpression?
      @falseExpression.cache data
    no

  render: (data) ->
    if evaluate data, @condition...
      @trueExpression.render data
    else if @falseExpression?
      @falseExpression.render data
    else ''
    