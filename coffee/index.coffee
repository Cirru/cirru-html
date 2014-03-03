
{parseShort} = require 'cirru-parser'

{makeAbstract} = require './abstract'
{makeCache} = require './cache'
{renderTree} = require './render'

exports.render = (template, data) ->
  # data._filename may be useful
  (parseShort template)
  .map (syntaxTree) ->
    abstractTree = makeAbstract syntaxTree
    cachedTree = makeCache abstractTree
    renderTree cachedTree
  .join ''