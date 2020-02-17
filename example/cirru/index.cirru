
doctype

html
  head
    title "Cirru HTML"
    meta $ :charset utf-8
    link (:rel stylesheet)
      :href http://cdn.tiye.me/favored-fonts/main-fonts.css
    link (:rel icon)
      :href http://cdn.tiye.me/logo/cirru.png
    script (:defer) $ :src $ @ js
  body
    #header
      #title "Cirru HTML"

      #about
        span#hint
        = "Minimalistic templating. Find more on "
        a (:href https://github.com/Cirru/cirru-html)
          :target _blank
          = GitHub
        = ". This is also part of "
        a
          :href "http://cirru.org"
          = "Cirru Project"
        = "."

    #grammars
      #html.grammar.long
        .note
          .line
            = "Tags and attributes in Cirru are using strings directly(no escaping yet)."
            = " <tt>div</tt>s generates to tags, <tt>:attr</tt>s generates attributes."
            = " All in Cirru syntax."
        .test
          textarea.file $ = (@insert html.cirru)
          textarea.data $ = (@insert ../data/html.js)
          button.button "Compiles to"
          textarea.result
      #special.grammar
        .note
          .line
            = "<tt>doctype</tt> generates <tt>&lt;DOCTYPE html&gt;</tt>"
            = ", it's a special static value."
          .link
            = "<tt>--</tt> refers to comments"
            = ", you may also use <tt>-- $</tt>."
        .test
          textarea.file $ = (@insert special.cirru)
          textarea.data $ = (@insert ../data/special.js)
          button.button "Compiles to"
          textarea.result
      #at.grammar
        .note
          .line
            = "<tt>@</tt> to insert from variables."
            = " It's for <tt>innerText</tt> and attributes."
        .test
          textarea.file $ = (@insert at.cirru)
          textarea.data $ = (@insert ../data/at.js)
          button.button "Compiles to"
          textarea.result
      #methods.grammar
        .note
          = "Custom methods are supported, for example:"
        .test
          textarea.file $ = (@insert methods.cirru)
          textarea.data $ = (@insert ../data/methods.js)
          button.button "Compiles to"
          textarea.result
      #if.grammar
        .note
          = "<tt>if</tt> instruction:"
        .test
          textarea.file $ = (@insert if.cirru)
          textarea.data $ = (@insert ../data/if.js)
          button.button "Compiles to"
          textarea.result
      #block.grammar.long
        .note
          = "<tt>block</tt> for creating a fragment of tags:"
        .test
          textarea.file $ = (@insert block.cirru)
          textarea.data $ = (@insert ../data/block.js)
          button.button "Compiles to"
          textarea.result
      #repeat.grammar
        .note
          = "List grammar is like in logic-less template engines."
          = " <tt>@key</tt> and <tt>@value</tt> are created internally."
        .test
          textarea.file $ = (@insert repeat.cirru)
          textarea.data $ = (@insert ../data/repeat.js)
          button.button "Compiles to"
          textarea.result
      #with.grammar
        .note
          = "<tt>with</tt> for loading data as a scope:"
        .test
          textarea.file $ = (@insert with.cirru)
          textarea.data $ = (@insert ../data/with.js)
          button.button "Compiles to"
          textarea.result
      #insert.grammar
        .note
          = "<tt>@insert</tt> for loading content from files for other sources(where you can specify in API):"
        .test
          textarea.file $ = (@insert insert.cirru)
          textarea.data $ = (@insert ../data/insert.js)
          button.button "Compiles to"
          textarea.result
      #partial.grammar
        .note
          = "<tt>@partial</tt> for loading content from other <tt>.cirru</tt> templates"
        .test
          textarea.file $ = (@insert partial.cirru)
          textarea.data $ = (@insert ../data/partial.js)
          button.button "Compiles to"
          textarea.result
