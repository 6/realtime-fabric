_.extend Template.hello,
  greeting: -> "Welcome to realtime-fabric."
  events:
    'click input' : ->
      canvas.add new fabric.Rect
        width: random_range(30, 70)
        height: random_range(30, 70)
        left: random_range(30, 500)
        top: random_range(30, 250)
        fill: "rgb(#{random_range(70, 200)},#{random_range(70, 200)},255)"

Meteor.startup ->
  window.canvas = new fabric.Canvas('c')
