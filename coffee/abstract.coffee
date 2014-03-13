
{singleTags} = require './tag/single'

pkgPair = require './tag/pair'
pkgSingle = require './tag/single'
pkgText = require './tag/text'

pkgIf = require './expression/if'
pkgRepeat = require './expression/repeat'
pkgWith = require './expression/with'
pkgInsert = require './expression/insert'
pkgPartial = require './expression/partial'
pkgBlock = require './expression/block'
pkgMethods = require './expression/methods'
pkgAt = require './expression/at'

exports.makeAbstract = (syntaxTree) ->
  func = syntaxTree[0]
  args = syntaxTree[1..]

  unless func? and func.length > 0 and typeof func is 'string'
    throw new Error "(#{func}) is not a valid syntax in template"

  if func[0] is '@'
    switch func[1..]
      when '' then new pkgAt.Expression syntaxTree
      when 'if' then new pkgIf.Expression syntaxTree
      when 'repeat' then new pkgRepeat.Expression syntaxTree
      when 'with' then new pkgWith.Expression syntaxTree
      when 'insert' then new pkgInsert.Expression syntaxTree
      when 'partial' then new pkgPartial.Expression syntaxTree
      when 'block' then new pkgBlock.Expression syntaxTree
      else new pkgMethods.Expression syntaxTree
  else if func[0..1] is '--'
    new pkgSingle.Tag syntaxTree
  else if func[0] in ['#', '.']
    new pkgSingle.Tag syntaxTree
  else if func[0].match /\w/
    tagName = func.match(/^\w+/)[0]
    if tagName in singleTags
      new pkgSingle.Tag syntaxTree
    else
      new pkgPair.Tag syntaxTree
  else if func[0] is '='
    new pkgText.Tag syntaxTree
  else
    throw new Error "(#{func}) is not recognized"
