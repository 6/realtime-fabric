# Define Minimongo collections to match server/server.coffee
Rooms = new Meteor.Collection("rooms")
Objects = new Meteor.Collection("objects")

# ID of current room
Session.set('room_id', null)

# Subscribe to 'rooms' collection on startup
# Select a room once data has arrived.
Meteor.subscribe 'rooms', ->
  if not Session.get('room_id')
    room = Rooms.findOne({}, {sort: {name: 1}})
    Router.set_room(room._id) if room?
    
# Always be subscribed to the shapes for the selected room.
Meteor.autosubscribe ->
  room_id = Session.get('room_id')
  Meteor.subscribe('objects', room_id) if room_id?

#### Helpers for in-place editing

# Returns an event_map key for attaching "ok/cancel" events to
# a text input (given by selector)
okcancel_events = (sel) -> "keyup #{sel}, keydown #{sel}, focusout #{sel}"

# Creates an event handler for interpreting "escape", "return", and "blur"
# on a text field and calling "ok" or "cancel" callbacks.
make_okcancel_handler = (options) ->
  ok = options.ok or ->
  cancel = options.cancel or ->
  return (evt) ->
    if evt.type is "keydown" && evt.which is 27
      # escape = cancel
      cancel.call(@, evt)
    else if evt.type is "keyup" && evt.which is 13 or evt.type is "focusout"
      # blur/return/enter = ok/submit if non-empty
      value = String(evt.target.value or "")
      if value?
        ok.call(@, value, evt)
      else
        cancel.call(@, evt)

#### Rooms

Template.rooms.rooms = -> Rooms.find({}, {sort: {name: 1}})

Template.rooms.events = {}

# Attach events to keydown, keyup, and blur on "New room" input box.
Template.rooms.events[okcancel_events('#new-room')] = make_okcancel_handler
  ok: (text, evt) ->
    text = $.trim(text)
    return if text == ""
    id = Rooms.insert(name: text)
    Router.set_room(id)
    evt.target.value = ""
    
Template.room.selected = ->
  if Session.equals('room_id', @_id) then 'selected' else ''
    
Template.room.events =
  'mousedown': (evt) ->
    Router.set_room(@_id)

_.extend Template.canvas,
  events:
    'click input' : ->
      canvas.add new fabric.Rect
        width: random_range(30, 70)
        height: random_range(30, 70)
        left: random_range(30, 700)
        top: random_range(30, 250)
        fill: "rgb(#{random_range(70, 200)},#{random_range(70, 200)},255)"

RoomsRouter = Backbone.Router.extend
  routes:
    ":room_id": "main"

  main: (room_id) ->
    window.canvas.clear()
    Session.set("room_id", room_id)

  set_room: (room_id) ->
    @navigate(room_id, true)

Router = new RoomsRouter

Meteor.startup ->
  window.canvas = new fabric.Canvas('c')
  Backbone.history.start(pushState: true)
