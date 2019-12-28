
@block
  div
    = 1
  div
    = 2
  div
    = 3

@if (@ switcher)
  @block
    span
      = true
  @block
    span
      = false

@if (@ no-switcher)
  @block
    span
      = true
  @block
    span
      = false

@if (@ switcher)
  @block
    span
      = true