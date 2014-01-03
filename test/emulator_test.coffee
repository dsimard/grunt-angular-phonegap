grunt = require("grunt")
sinon = require '../node_modules/sinon'

emulator = require('../lib/emulator')(grunt, "android")
shell = grunt.config.data.shell

stubList = (list)->
  stub = sinon.stub emulator, "list", (cb)->
    cb(list)

exports.module = 
  setUp: (done) ->
    done()

  'emulator not started': (test)->
    stub = stubList []
    
    emulator.shellArgs (cmd)->
      test.equal 'local run android --emulator', cmd.join(" ")
      stub.restore()
      test.done()

  'single emulator started': (test)->
    stub = stubList ['single']
    
    emulator.shellArgs (cmd)->
      test.equal 'install android --emulator=single', cmd.join(" ")
      stub.restore()
      test.done()

  'two emulators started, use first one': (test)->
    stub = stubList ['first', 'second']
    
    emulator.shellArgs (cmd)->
      test.equal 'install android --emulator=first', cmd.join(" ")
      stub.restore()
      test.done()

  'two emulators started, use selected': (test)->
    stub = stubList ['first', 'second']
    
    emulator.shellArgs "second", (cmd)->
      test.equal 'install android --emulator=second', cmd.join(" ")
      stub.restore()
      test.done()

  'two emulators started, use one that does not exist': (test)->
    stub = stubList ['first', 'second']
    
    emulator.shellArgs "third", (cmd)->
      test.equal 'install android --emulator=first', cmd.join(" ")
      stub.restore()
      test.done()