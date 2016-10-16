assert = require 'assert'
buildCio = require 'cio'
buildListener = require '../../lib'

# no builder options yet...
cio = buildCio()

describe 'test emitter', ->

  describe 'with socket', ->

    builderOptions = {}

    # build the listener
    listener = buildListener builderOptions

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
    listener fakeSocket

    before 'wait for emitter event', (done) -> setTimeout done, 10

    it 'should return a listener function', ->
      assert.equal (typeof listener), 'function'

    it 'should call listener to create the emitter and attach to the socket', ->
      assert fakeSocket.emitter

    # TODO: test event 'emitter' is emitted
    it 'should emit the \'emitter\' event', ->
      assert.deepEqual fakeSocket.emits.emitter[0], fakeSocket.emitter

    # TODO: test emitting something and ensure it goes out thru fakeSocket?
