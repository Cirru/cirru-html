
exports.Expression = class
  constructor: (tree) ->
    @tree = tree
    @func = tree[0][1..]
    @args = tree[1..]

  cache: (data) ->
    no

  render: (data) ->
    list = @args.map (item) -> data[item]
    if not data[@func]?
      console.error "Evaludatiing tree", JSON.stringify(@tree)
      throw new Error('Unknown method')
    data[@func] list...