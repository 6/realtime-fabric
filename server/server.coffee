Rooms = new Meteor.Collection("rooms")
Objects = new Meteor.Collection("objects")

# Publish complete set of lists to all clients.
Meteor.publish 'rooms', -> Rooms.find()

# Publish all shapes for requested room_id.
Meteor.publish 'objects', (room_id) -> Objects.find(room_id: room_id)

Meteor.startup ->
  # code to run on server at startup
