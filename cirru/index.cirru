
doctype

html
  head
    title "Cirru HTML"
    meta $ :charset utf-8
    link (:rel stylesheet) $ :href css/style.css
    link (:rel icon)
      :href http://cirru.qiniudn.com/cirru-32x32.png
    script (:defer) $ :src build/build.js
  body
    #entry
    @repeat (@ names)
      .test
        :id (@ @value)
        pre.file $ :contenteditable
        pre.data $ :contenteditable
        button.button
          @ @value
          = " =>"
        pre.result $ :contenteditable