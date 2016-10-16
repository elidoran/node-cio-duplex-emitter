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

```javascript
// get the module's builder function
var buildCio = require('cio');

// pass this module's name to the core module: `cio` as a plugin
var cio = buildCio({
  // can specify many plugins in this array
  plugins: [ '@cio/duplex-emitter' ]
});

//  OR: provide options for a plugin too:
var cio = buildCio({
  plugins: [
    { plugin: '@cio/duplex-emitter', options: {some: 'options'} }
  ]
});

// could alternatively do any of the following:

// pass the plugin info to the `cio.use()` function
cio.use('@cio/duplex-emitter');

//  OR: and with some plugin options
cio.use('@cio/duplex-emitter', { some: 'options' });

//  OR: provide the function to use()
var fn = require('@cio/duplex-emitter');
cio.use(fn);

//  OR: provide the function with options
cio.use(fn, { some: 'options' });


// now make a client

// some options...
var options = {};

// create it with the options
client = cio.client(options);

// the result is a client socket created by `net.connect()`
// when it connects it will do:
// client.emitter = new DuplexEmitter(socket)
// client.emit('emitter', emitter, client)
// so, you can:
client.on('emitter', function(emitter, client) {
  emitter.on('some-event', someListener);
  // and more...
});
// NOTE: it emits 'emitter' in `nextTick()` so you have a chance to add
// a listener for that event before it is emitted.

// if you specify key/cert, and optionally `ca`, values
// then it'll use `tls.connect()` instead for secure communication.

// Do the same with cio.server(...) for server side connection setup,
// including secure communication

```

## MIT License
