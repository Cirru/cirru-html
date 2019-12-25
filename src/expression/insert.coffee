
exports.Expression = class
  constructor: (tree) ->
    @childFile = tree[1]

    @cachedInnerHTML = undefined

  cache: (data) ->
    @cachedInnerHTML = @render data
    yes

  resolve: ->
    throw new Error 'use .setResolver to add solver'

  render: (data) ->
    if @cachedInnerHTML?
      return @cachedInnerHTML
    unless @childFile?
      throw new Error "base path of command insert missing"

    html = @resolve data['@filename'], @childFile