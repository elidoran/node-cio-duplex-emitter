assert = require 'assert'
buildCio = require 'cio'
listener = require '../../lib'

# no builder options yet...
cio = buildCio()

describe 'test duplex-emitter', ->

  describe 'with socket', ->

    describe 'and enabled', ->

      # pass a fake socket to the listener
      fakeSocket =
        events: {}
        emits: {}
        pipe: (stream) ->
          stream.pipedFrom = this
          return stream
        on: (event, listener) ->
          @events[event] = listener
        emit: (event, args...) ->
          @emits[event] = args

      # call the listener as if a new socket connection has been made
      context =
        client: fakeSocket
        duplexEmitter: true

      listener.call context

      before 'wait for emitter event', (done) -> setTimeout done, 10

      it 'should call listener to create the emitter and attach to the socket', ->

        assert fakeSocket.duplexEmitter

      # TODO: test event 'emitter' is emitted
      it 'should emit the \'duplex-emitter\' event', ->
        assert.deepEqual fakeSocket.emits['duplex-emitter'][0], fakeSocket.duplexEmitter

      # TODO: test emitting something and ensure it goes out thru fakeSocket?

    describe 'and explicitly disabled', ->

      context =
        duplexEmitter: false
        client: {}

      it 'should do nothing', -> listener.call context # no error occurs...

    describe 'and implicitly disabled', ->

      context =
        client: {}

      it 'should do nothing', -> listener.call context # no error occurs...
