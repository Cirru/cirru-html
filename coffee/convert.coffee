
singleTags = 'area base br col command embed hr'
singleTags+= ' img input keygen link meta param source track wbr'
singleTags = singleTags.split ' '

cirru = require 'cirru-parser'

exports.convert = (code) ->
  ast = cirru.parseShort code

  console.log ast