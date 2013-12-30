{inspect} = require 'util'
{exec} = require('child_process')
_ = require '../node_modules/underscore'

module.exports = (grunt, target)->
  if target isnt 'android'
    grunt.log.error "Not available for #{target}".red
    grunt.log.error ["Help me improving this project by emailing me at", "dsimard@azanka.ca".bold].join " "

  # Load emulator from cordova
  emulator = require('./cordova_lib')(grunt, target).req "emulator"

  r =
    # Start the emulator
    emulate : (emulatorName, callback)->
      r.shellArgs emulatorName, (args)->
        grunt.verbose.writeln "Starting emulator : phonegap #{args.join(" ")}" 
        child = exec "phonegap #{args.join " "}", (err, stdout, stderr)->
          grunt.verbose.error "Error when starting emulator : #{err}" if err?
          grunt.verbose.error "Emulator stderr : #{stderr}" if stderr?
          grunt.verbose.writeln "Emulator stdout : #{stdout}" if stdout?
          callback()

    # List all running emulators
    list : (callback)->      
      emulator.list_started()
        .then (list)->
          callback(list)
        .then null, (err)->
          grunt.verbose.error "Error listing started emulators : #{err}"
          callback []

    # Return the command for shell
    shellArgs : (emulatorName=null, callback)->
      if _.isFunction(emulatorName)
        callback = emulatorName
        emulator = null

      r.list (emulators)->      
        # Start an emulator if none is running
        if _.isEmpty(emulators)
          callback ["local", "run", target, "--emulator"]
        else
          args = ["install", target]
          if emulatorName? && _.contains(emulators, emulatorName)
            # Use the specified one
            args.push "--emulator=#{emulatorName}"
          else
            # Use the first one
            args.push "--emulator=#{_.first(emulators)}"

          callback args