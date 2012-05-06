Rooms = new Meteor.Collection("rooms")
Shapes = new Meteor.Collection("shapes")

# Publish complete set of lists to all clients.
Meteor.publish 'rooms', -> Rooms.find()

# Publish all shapes for requested room_id.
Meteor.publish 'shapes', (room_id) -> Shapes.find(room_id: room_id)

Meteor.startup ->
  # code to run on server at startup
