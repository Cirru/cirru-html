
exports.Expression = class
  constructor: (tree) ->
    @variable = tree[1]

  cache: (data) ->
    no 

  render: (data) ->
    data[@variable] or ''