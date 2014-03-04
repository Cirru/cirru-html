
exports.MethodsExpression =
class MethodsExpression
  constructor: (tree) ->
    @func = tree[0][1..]
    @args = tree[1..]

  cache: (data) ->
    no

  @render: (data) ->
    list = @args.map (item) -> data[item]
    data[@func] list...