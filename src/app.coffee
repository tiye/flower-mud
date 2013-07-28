
path = require 'path'
http = require 'http'
mime = require 'mime'
fs = require 'fs'
{match} = require 'coffee-pattern'

app = http.createServer (req, res) ->
  res.writeHead 200, 'Content-Type': (mime.lookup req.url)

  reply = (error, data) ->
    if error?
      res.writeHead 500
      res.end "server has error: #{error}"
    else if data?
      if data.code?
        res.writeHead data.code, 'Location': data.url
        res.end ''
      else
        res.writeHead 200, 'Content-Type': (mime.lookup req.url)
        res.end data.content
    else
      res.writeHead 404
      res.end 'nothing found'

  match req.url,
    '/', (redirect_chooser reply)
    '/choose/list.json', (file_list reply)
    /^\/choose/, (app_chooser reply)
    null, (open_app reply)

redirect_chooser = (reply) -> (the_url) ->
  reply null, {url: '/choose/index.html', code: 302}

file_list = (reply) -> (the_url) ->
  fs.readdir './', (err, list) ->
    if err? then reply err
    else reply null, {content: (JSON.stringify list)}

app_chooser = (reply) -> (the_url) ->
  the_url = the_url.replace /^\/choose/, ''
  fs.readFile (path.join __dirname, '../', the_url), (err, content) ->
    if err? then reply err
    else reply null, {content}

open_app = (reply) -> (the_url) ->
  fs.readFile (path.join process.env.PWD, the_url), (err, content) ->
    if err? then reply err
    else reply null, {content}

app.listen 3100