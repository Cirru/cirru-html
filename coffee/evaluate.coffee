
exports.evaluate = (scope, xs...) ->
  func = scope[xs[0]]
  func xs[1..].map (x) -> scope[x]