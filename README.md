# @cio/duplex-emitter
[![Build Status](https://travis-ci.org/elidoran/node-cio-duplex-emitter.svg?branch=master)](https://travis-ci.org/elidoran/node-cio-duplex-emitter)
[![Dependency Status](https://gemnasium.com/elidoran/node-cio-duplex-emitter.png)](https://gemnasium.com/elidoran/node-cio-duplex-emitter)
[![npm version](https://badge.fury.io/js/%40cio%2Fduplex-emitter.svg)](http://badge.fury.io/js/%40cio%2Fduplex-emitter)

Use two way event system for client/server communication.

Uses module [duplex-emitter](https://www.npmjs.com/package/duplex-emitter).

## Install

```sh
npm install @cio/duplex-emitter --save
```

## Usage

Uses `duplex-emitter` to setup a two-way remote event communication.

Enable it with the `duplexEmitter:true` options property and it will produce a `socket.duplexEmitter` sub-property and emit a 'duplex-emitter' event.

```javascript
// get the `cio` module's builder function and build one
var buildCio = require('cio')
  , cio = buildCio();

// provide the module name to load it for the specific type of socket
cio.onClient('@cio/duplex-emitter');
cio.onServerClient('@cio/duplex-emitter');

// OR: provide the function
var fn = require('@cio/duplex-emitter');
cio.onClient(fn);
cio.onServerClient(fn);


// tell this listener to do its thing for this client
var options = { duplexEmitter:true }
  , client = cio.client(options)
  , server = cio.server(options);

// the result is sockets connect (client and server client) it will do:
//   socket.duplexEmitter = DuplexEmitter(socket);
//   socket.emit('duplex-emitter', socket.duplexEmitter, socket);
// so, you can do this for both `client` and `server`
client.on('duplex-emitter', function(emitter, socket) {
  emitter.on('some-event', someListener);
  // and more...
});
// NOTE: it emits 'emitter' in `nextTick()` so you have a chance to add
// a listener for that event before it is emitted.

// if you specify key/cert, and optionally `ca`, values
// then it'll use `tls.connect()` instead for secure communication.
```

## MIT License
