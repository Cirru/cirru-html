
{join} = require 'path'
fs = require 'fs'
{parseShort} = require 'cirru-parser'

exports.InsertExpression = class InsertExpression
  constructor: (tree) ->
    @childFile = tree[1]

    @cachedInnerHTML = undefined

  cache: (data) ->
    @cachedInnerHTML = @render data
    yes

  render: (data) ->
    if @cachedInnerHTML?
      return @cachedInnerHTML
    unless @childFile?
      throw new Error "base path of command insert missing"
    basePath = data['@filename']
    destPath = join basePath, @childFile
    unless fs.existsSync destPath
      throw new Error "no dest (#{basePath}) (@childFile)"
    html = fs.readFileSync destPath, 'utf8'