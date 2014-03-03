
singleTags = 'area base br col command embed hr'
singleTags+= ' img input keygen link meta param source track wbr'
exports.singleTags = singleTags.split ' '

{CommonTag} = require './common'

exports.SingleTag = class SingleTag extends CommonTag
  render: (data) ->
    attrs = @renderAttrs data
    if attrs.length > 0
      "<#{@tagName} #{attrs}>"
    else
      "<#{@tagName}>"