
buildEmitter = require 'duplex-emitter'

module.exports = (options) ->

  # build the listener function and return it
  # usable for: 'connect', 'connection', and 'secureConnection' events
  (socket) ->

    # crate emitter and store it on the socket
    socket.emitter = emitter = buildEmitter socket

    # emit 'emitter' event to allow them to do their own initial work
    # they don't have the socket yet, so, let's do this in the future
    process.nextTick -> socket.emit 'emitter', emitter, socket
