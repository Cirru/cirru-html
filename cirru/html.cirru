
meta (:charset utf-8)
div (:class demo-a demo-b)
  = demo of text
  :data root node
  span $ = nothing
  div
    p $ h3
      = This page is converted from Cirru
    span (= see "on ")
    a (:href https://github.com/Cirru/cirru-html)
      = GitHub
  = plain text
#entry.demo (:class c)
div.demo
div#demo $ = content
.class-a