
require('calabash').do 'dev',
  'pkill -f doodle'
  'pkill -f "node-dev src/main.coffee"'
  'jade -o ./ -wP layout/index.jade'
  'stylus -o build/ -w layout/'
  'coffee -o lib/ -wbmc src/'
  'coffee -o build/ -wmbc coffee/'
  'node-dev src/app.coffee'
  'doodle build/'