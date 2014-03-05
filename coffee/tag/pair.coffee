
common = require './common'

exports.Tag = class extends common.Tag
  name: 'pair'
  render: (data) ->
    attrs = @renderAttrs data
    innerHTML = @renderInnerHTML data
    if attrs.length > 0
      "<#{@tagName} #{attrs}>#{innerHTML}</#{@tagName}>"
    else
      "<#{@tagName}>#{innerHTML}</#{@tagName}>"

  renderInnerHTML: (data) ->
    if @cachedInnerHTML?
      return @cachedInnerHTML
    buffer = ''
    for item in @children
      buffer += item.render data
    buffer