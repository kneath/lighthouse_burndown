jQuery.fn.timelineGraph = function(){
  return this.each(function(){
    
    // Hide the original table
    $(this).css({
      position: 'absolute',
      left: '-9999px',
      top: '-9999px'
    });
    
    // Grab the data from the table
    var labels = [], data = [];
    $(this).find('tfoot th').each(function(){
      labels.push($(this).html());
    });
    $(this).find('tbody td').each(function(){
      data.push($(this).html())
    });
    
    // Prepare variables for drawing
    var width = 790, height = 250, leftgutter = 0, rightgutter = 0, topgutter = 15, bottomgutter = 25;
    var colorhue = 0.75, color = "#ffb240";
    var r = Raphael("holder", width, height);
    var txt =  {"font": '12px "Helvetica"', "font-weight": "bold", stroke: 'none', fill: '#000'},
        txt1 = {"font": '12px "Helvetica"', "font-weight": "bold", stroke: 'none', fill: '#000'},
        txt2 = {"font": '12px "Helvetica"', stroke: 'none', fill: '#000'}
    var X = (width - leftgutter) / labels.length,
        max = Math.max.apply(Math, data),
        Y = (height - bottomgutter - topgutter) / max;
    
    // Draw the grid ?
    r.drawGrid(leftgutter + X*0.5, topgutter, width - leftgutter - X, height - topgutter - bottomgutter, 10, 10, "#ddd");
    var path =  r.path({stroke: color, "stroke-width": 3, "stroke-linejoin": "round"}),
        bgp =   r.path({stroke: "none", opacity: 0.3, fill: color}).moveTo(leftgutter + X*0.5, height - bottomgutter),
        frame = r.rect(10, 10, 100, 40, 5).attr({fill: "#eee", stroke: "#ccc", "stroke-width": 2}).hide();
    
    // Labels ?
    var label = [],
        is_label_visible = false,
        leave_timer,
        blanket = r.set();
    
    label[0] = r.text(60, 10, "24 tickets").attr(txt).hide();
    label[1] = r.text(60, 40).attr(txt1).attr({fill: "#666"}).hide();
    
    for(var i=0, ii=labels.length; i<ii; i++){
      var y = Math.round(height - bottomgutter - Y * data[i]),
          x = Math.round(leftgutter + X * (i + 0.5)),
          t = r.text(x, height - 6, labels[i]).attr(txt).toBack();
      bgp[i == 0 ? "lineTo" : "cplineTo"](x, y, 10);
      path[i == 0 ? "moveTo" : "cplineTo"](x, y, 10);
      var dot = r.circle(x, y, 6).attr({fill: color, stroke: "#fff", "stroke-width": 2});
      blanket.push(r.rect(leftgutter + X * i, 0, X, height - bottomgutter).attr({stroke: "none", fill: "#fff", opacity: 0}));
      var rect = blanket[blanket.length - 1];
      (function(x, y, data, lbl, dot){
        var timer, i = 0;
        $(rect.node).hover(function(){
          clearTimeout(leave_timer);
          var newcoord = {x: x*1 + 7.5, y: y - 19};
          if (newcoord.x + 100 > width){
            newcoord.x -= 114;
          }
          frame.show().animate({x: newcoord.x, y:newcoord.y}, 200*is_label_visible);
          label[0].attr({text:data + " ticket" + ((data == 1) ? "" : "s")}).show().animate({x: newcoord.x*1 + 50, y:newcoord.y*1 + 12}, 200 *is_label_visible);
          label[1].attr({text: lbl}).show().animate({x: newcoord.x * 1 + 50, y: newcoord.y * 1 + 27}, 200 * is_label_visible);
          dot.attr("r", 7);
          is_label_visible = true;
          r.safari();
        }, function(){
          dot.attr("r", 5);
          r.safari();
          leave_timer = setTimeout(function(){
            frame.hide();
            label[0].hide();
            label[1].hide();
            is_label_visible = false;
            r.safari();
          }, 1);
        })
      })(x, y, data[i], labels[i], dot);
    }
    
    bgp.lineTo(x, height - bottomgutter).andClose();
    frame.toFront();
    label[0].toFront();
    label[1].toFront();
    blanket.toFront();
  });
}