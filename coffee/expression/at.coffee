
exports.AtExpression = class AtExpression
  constructor: (tree) ->
    @variable = tree[1]

  cache: (data) ->
    no 

  render: (data) ->
    data[@variable]