
require 'shelljs/make'

target.dev = ->
  exec 'pkill -f doodle', ->
    exec 'doodle log:yes index.html cirru/ build/build.js', async: yes
  exec 'coffee -o src/ -wbc coffee', async: yes
  exec 'watchify -o build/build.js -d src/demo.js -v', async: yes