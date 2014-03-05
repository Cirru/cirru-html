
{parseShort} = require 'cirru-parser'

abstract = require './abstract'

exports.renderer = (template, initData) ->
  syntaxTree = parseShort template
  syntaxTree.unshift '@block'

  abstractTree = abstract.makeAbstract syntaxTree
  abstractTree.cache initData

  (data) -> abstractTree.render data