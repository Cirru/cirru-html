
abstract = require '../abstract'

exports.Expression = class
  constructor: (tree) ->
    @args = tree[1..]

    @cachedInnerHTML = undefined

    @condition = undefined
    @trueExpression = undefined
    @falseExpression = undefined

    @readArgs()

  readArgs: ->
    @condition = abstract.makeAbstract args[0]
    @trueExpression = abstract.makeAbstract args[1]
    @falseExpression = abstract.makeAbstract args[2] if args[2]?

  cache: (data) ->
    @trueExpression.cache data
    if @falseExpression?
      @falseExpression.cache data
    no

  render: (data) ->
    if @condition.render data
      @trueExpression.render data
    else if @falseExpression?
      @falseExpression.render data
    else ''
    