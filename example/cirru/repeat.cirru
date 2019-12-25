
@repeat (@ list)
  div
    = a line
    p $ = (@ @key)
    p $ = (@ @value)

    @if (@ @last)
      p $ = this is last one

    @if (@ @first)
      p $ = this is the first