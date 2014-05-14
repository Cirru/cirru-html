
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
    obj = @variable.render data
    unless typeof obj is 'object'
      throw new Error "(#{@variable}) supposed to be an object"
    obj.__proto__ = data
    for item in @children
      buffer += item.render obj
    buffer