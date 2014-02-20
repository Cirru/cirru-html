
require('calabash').run [
  'pkill -f doodle'
  'coffee -o src/ -bcw coffee/'
  'cjsify -o build/build.js -wv coffee/demo.coffee'
  'doodle index.html build/build.js log:yes'
]