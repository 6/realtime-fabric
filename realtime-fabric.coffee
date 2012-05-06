if Meteor.is_client
  _.extend Template.hello,
    greeting: -> "Welcome to realtime-fabric."
    events:
      'click input' : ->
        canvas = new fabric.Canvas('c')
        canvas.add new fabric.Rect
          width: 50
          height: 50
          left: 50
          top: 50
          fill: 'rgb(255,0,0)'

if Meteor.is_server
  Meteor.startup ->
    # code to run on server at startup
