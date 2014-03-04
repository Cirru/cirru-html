
{CommonTag} = require './common'

exports.PairTag = class PairTag extends CommonTag
  render: (data) ->
    attrs = @renderAttrs data
    innerHTML = @renderInnerHTML data
    if attrs.length > 0
      "<#{@tagName} #{attrs}>#{innerHTML}</#{tagName}>"
    else
      "<#{@tagName}>#{innerHTML}</#{tagName}>"

  renderInnerHTML: (data) ->
    if @cachedInnerHTML?
      return @cachedInnerHTML
    buffer = ''
    for item in @children
      buffer += item.render data
    buffer