{inspect} = require 'util'

r = (grunt)->
  cordovaLib = require('../cordova_lib')(grunt, "android")

  check =
    # Check if ADB is present
    checkAdb : ->
      # Check adb version
      grunt.verbose.writeln "Calling `shell:checkAdb`"
      grunt.task.run ["shell:checkAdb"]


    # Run check_reqs
    run: (callback)->
      check.checkAdb callback

      # Get the `check_reqs.js` file from phonegap
      checkReqs = cordovaLib.req 'check_reqs'

      if checkReqs?
        success = ->
          grunt.log.ok 'Looks like your environment fully supports cordova-android development!'.bold.green
          callback()

        failure = (err)->
          grunt.log.error err.bold.red
          callback(err)

        checkReqs.run().done success, failure

      else
        msg = "Cannot find `check_reqs.js`"
        grunt.log.error msg.red
        callback msg

module.exports = r