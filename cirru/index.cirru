
doctype

html
  head
    title "Cirru HTML"
    meta $ :charset utf-8
    link (:rel stylesheet) $ :href css/style.css
    link (:rel icon)
      :href http://cirru.qiniudn.com/cirru-32x32.png
    script (:defer) $ :src build/main.js
  body
    #header
      #title "Cirru HTML"
      #hint "-- an indentation based template engine"
      #about
        = "You may refer to "
        a (:href https://github.com/Cirru/cirru-html)
          :target _blank
          = GitHub
        = " for more detail about hot to use it."
    #grammars
      #html.grammar.long
        .note
          .line
            = "You may recognize tags and attributes in Cirru are quite stright-forward."
            = " Methods make tags, and <tt>:attr</tt> generates attributes."
            = " And all it's Cirru grammar here."
        .test
          textarea.file $ = (@insert html.cirru)
          textarea.data $ = (@insert ../compiled/data/html.js)
          button.button =>
          textarea.result
      #special.grammar
        .note
          .line
            = "<tt>doctype</tt> generates <tt>&lt;DOCTYPE html&gt;</tt>"
            = ", actually Cirru only generates this one."
          .link
            = "<tt>--</tt> is a method to wrap comments"
            = ", you may use <tt>-- $</tt> for short."
        .test
          textarea.file $ = (@insert special.cirru)
          textarea.data $ = (@insert ../compiled/data/special.js)
          button.button =>
          textarea.result
      #at.grammar
        .note
          .line
            = "Using <tt>@</tt> to insert load variables."
            = " It's available for innerText and attributes."
        .test
          textarea.file $ = (@insert at.cirru)
          textarea.data $ = (@insert ../compiled/data/at.js)
          button.button =>
          textarea.result
      #methods.grammar
        .note
          = "Somehow, customized methods are also supported, writing like this:"
        .test
          textarea.file $ = (@insert methods.cirru)
          textarea.data $ = (@insert ../compiled/data/methods.js)
          button.button =>
          textarea.result
      #if.grammar
        .note
          = "This is <tt>if</tt> syntax:"
        .test
          textarea.file $ = (@insert if.cirru)
          textarea.data $ = (@insert ../compiled/data/if.js)
          button.button =>
          textarea.result
      #block.grammar.long
        .note
          = "And <tt>block</tt> put a block of code into one:"
        .test
          textarea.file $ = (@insert block.cirru)
          textarea.data $ = (@insert ../compiled/data/block.js)
          button.button =>
          textarea.result
      #repeat.grammar
        .note
          = "List grammar is quite like that in logic-less template engines."
          = " <tt>@key</tt> and <tt>@value</tt> are writtern to that new scopes."
        .test
          textarea.file $ = (@insert repeat.cirru)
          textarea.data $ = (@insert ../compiled/data/repeat.js)
          button.button =>
          textarea.result
      #with.grammar
        .note
          = "And here comes <tt>with</tt> which load data as a scope:"
        .test
          textarea.file $ = (@insert with.cirru)
          textarea.data $ = (@insert ../compiled/data/with.js)
          button.button =>
          textarea.result
      #insert.grammar
        .note
          = "<tt>@insert</tt> is used to add raw file into Cirru HTML:"
        .test
          textarea.file $ = (@insert insert.cirru)
          textarea.data $ = (@insert ../compiled/data/insert.js)
          button.button =>
          textarea.result
      #partial.grammar
        .note
          = "<tt>@partial</tt> is like \"include\" of other languages"
          = ", but this time the loaded files should be in Cirru grammar."
        .test
          textarea.file $ = (@insert partial.cirru)
          textarea.data $ = (@insert ../compiled/data/partial.js)
          button.button =>
          textarea.result
