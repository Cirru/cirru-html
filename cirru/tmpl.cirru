
div
  "content of html"
div
  :href "demo of css"

  @if (@ name)
    span $ = "former is larger"
    span $ = "later is larger"

  @repeat (@ value)
    p
      span $ = key (@ @key)
      span $ = value (@ @value)

  @with (@ scope)
    p
      span (@ name) (@ title)

  @block
    div $ = a
    div $ = b

  @partial ga.cirru

  @insert ga.html

  div
    :href (@format name path)

  span
    = name (@fileter name save)