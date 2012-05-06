if Meteor.is_client
  _.extend Template.hello,
    greeting: -> "Welcome to realtime-fabric."
    events:
      'click input' : ->
        # template data, if any, is available in 'this'
        console.log("You pressed the button") if console?

if Meteor.is_server
  Meteor.startup ->
    # code to run on server at startup
