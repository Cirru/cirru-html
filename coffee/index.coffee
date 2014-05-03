
abstract = require './abstract'

exports.makeRender = (template, data = {}) ->

  if typeof template is 'object'
    syntaxTree = template
    syntaxTree.unshift '@block'
  else if typeof template is 'string'
    syntaxTree = require('cirru-parser').pare template
    syntaxTree.unshift '@block'

  abstractTree = abstract.makeAbstract syntaxTree
  abstractTree.cache data

  (data) -> abstractTree.render data

exports.render = (template, data) ->
  render = exports.makeRender template, data
  render data

exports.setResolver = (f) ->
  require('./expression/insert').Expression::resolve = f
  require('./expression/partial').Expression::resolve = f