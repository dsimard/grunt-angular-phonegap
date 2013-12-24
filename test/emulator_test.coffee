grunt = require("grunt")
sinon = require '../node_modules/sinon'

emulator = require('../lib/emulator')(grunt, "android")
shell = grunt.config.data.shell

exports.module = 
  setUp: (done) ->
    emulator.list.restore?()
    done()

  'emulator not started': (test)->
    stub = sinon.stub emulator, "list", ->[]

    test.equal 'phonegap local run android --emulator &', emulator.shellCommand()

    stub.restore()
    test.done()

  'single emulator started': (test)->
    stub = sinon.stub emulator, "list", ->['single']

    test.equal 'phonegap install --emulator=single android', emulator.shellCommand()

    stub.restore()
    test.done()

  'two emulators started, use first one': (test)->
    stub = sinon.stub emulator, "list", ->['first', 'second']

    test.equal 'phonegap install --emulator=first android', emulator.shellCommand()

    stub.restore()
    test.done()

  'two emulators started, use selected': (test)->
    stub = sinon.stub emulator, "list", ->['first', 'second']

    test.equal 'phonegap install --emulator=second android', emulator.shellCommand("second")

    stub.restore()
    test.done()