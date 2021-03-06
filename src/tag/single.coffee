
singleTags = 'doctype area base br col command embed hr'
singleTags+= ' img input keygen link meta param source track wbr'
exports.singleTags = singleTags.split ' '

common = require './common'

exports.Tag = class extends common.Tag
  name: 'single'
  render: (data) ->
    return '<!DOCTYPE html>' if @func is 'doctype'
    return '' if @func is '--'
    attrs = @renderAttrs data
    if attrs.length > 0
      "<#{@tagName} #{attrs}>"
    else
      "<#{@tagName}>"

  renderInnerHTML: (data) ->
    ''