// Generated by CoffeeScript 1.6.3
var match_name, render_data, to_html;

match_name = function(name) {
  return name.indexOf($('#input').val()) >= 0;
};

to_html = function(name) {
  return "<div class='entry'><div class='inside'>" + name + "</div></div>";
};

render_data = function(data) {
  $('#list').html(data.filter(match_name).map(to_html).join(''));
  return $('#list .entry').first().addClass('active');
};

$.fn.exists = function() {
  return this.length > 0;
};

$.getJSON('/choose/list.json', function(data) {
  $('#input').focus().keyup(function(event) {
    var _ref;
    if ((_ref = event.keyCode) !== 13 && _ref !== 38 && _ref !== 40) {
      return render_data(data);
    }
  });
  render_data(data);
  return $('#input').keydown(function(event) {
    var current, name, next, prev;
    switch (event.keyCode) {
      case 38:
        current = $('.active');
        prev = current.prev();
        if (prev.exists()) {
          current.removeClass('active');
          return prev.addClass('active');
        }
        break;
      case 40:
        current = $('.active');
        next = current.next();
        if (next.exists()) {
          current.removeClass('active');
          return next.addClass('active');
        }
        break;
      case 13:
        name = $('.active').text();
        return location.replace("/" + name + "/index.html");
    }
  });
});

/*
//@ sourceMappingURL=type.map
*/
