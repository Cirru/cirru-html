
{parseShort} = require 'cirru-parser'

{makeAbstract} = require './abstract'
{makeCache} = require './cache'
{renderTree} = require './render'

exports.renderer = (template, initData) ->
  syntaxTree = parseShort template
  syntaxTree.unshift '@block'

  abstractTree = makeAbstract syntaxTree
  abstractTree.cache initData

  (data) -> abstractTree.render data