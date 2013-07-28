
match_name = (name) -> name.indexOf($('#input').val()) >= 0
to_html = (name) ->
  "<div class='entry'><div class='inside'>#{name}</div></div>"
render_data = (data) ->
  $('#list').html data.filter(match_name).map(to_html).join('')
  $('#list .entry').first().addClass 'active'

$.fn.exists = -> @length > 0

$.getJSON '/choose/list.json', (data) ->
  $('#input').focus().keyup (event) ->
    unless event.keyCode in [13, 38, 40]
      render_data data
  render_data data
  $('#input').keydown (event) ->
    switch event.keyCode
      when 38 # up
        current = $('.active')
        prev = current.prev()
        if prev.exists()
          current.removeClass('active')
          prev.addClass('active')
      when 40 # down
        current = $('.active')
        next = current.next()
        if next.exists()
          current.removeClass('active')
          next.addClass('active')
      when 13 # enter
        name = $('.active').text()
        location.replace "/#{name}/index.html"