
buildEmitter = require 'duplex-emitter'

# usable for: 'connect', 'connection', and 'secureConnection' events
module.exports = ->

  # only do our work if the context contains `transform` options
  unless @duplexEmitter is true then return

  # we want the socket. doesn't matter whether its for a client or server client
  socket = @client ? @connection

  # create emitter and store it on the socket
  socket.duplexEmitter = emitter = buildEmitter socket

  # emit 'emitter' event to allow them to do their own initial work
  # they don't have the socket yet, so, let's do this in the future
  process.nextTick -> socket.emit 'duplex-emitter', emitter, socket

module.exports.options = id:'@cio/duplex-emitter'
