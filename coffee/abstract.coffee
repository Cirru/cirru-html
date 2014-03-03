
{singleTags, SingleTag} = require './tag/single'
{PairTag} = require './tag/pair'
{TextTag} = require './tag/text'

{IfExpression} = require './expression/if'
{RepeatExpression} = require './expression/repeat'
{WithExpression} = require './expression/with'
{InsertExpression} = require './expression/insert'
{IncludeExpression} = require './expression/include'
{BlockExpression} = require './expression/block'
{DefineExpression} = require './expression/define'
{MethodsExpression} = require './expression/methods'

exports.makeAbstract = makeAbstract = (syntaxTree) ->
  func = syntaxTree[0]
  args = syntaxTree[1..]

  unless func? and func.length > 1 and typeof func is 'string'
    throw new Error "(#{func}) is not a valid syntax in template"

  if func[0] is '@'
    switch func[1..]
      when 'if' then new IfExpression syntaxTree
      when 'repeat' then new RepeatExpression syntaxTree
      when 'with' then new WithExpression syntaxTree
      when 'insert' then new InsertExpression syntaxTree
      when 'include' then new IncludeExpression syntaxTree
      when 'define' then new DefineExpression syntaxTree
      else new MethodsExpression syntaxTree
  else if func[0] in ['#', '.']
    new PairTag syntaxTree
  else if func[0].match /[a-z]/
    tagName = func[0].match(/^\w+/)[0]
    if tagName in singleTags
      new SingleTag syntaxTree
    else
      new PairTag syntaxTree
  else if func[0] is '='
    new TextTag syntaxTree
  else
    throw new Error "(#{func}) is not recognized"
