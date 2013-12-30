path = require 'path'
{inspect} = require 'util'

r = (grunt)->
  cordovaLib = require('../cordova_lib')(grunt, "android")

  check =
    # Check if ADB is present
    checkAdb : ->
      # Check adb version
      grunt.verbose.writeln "Calling `shell:checkAdb`"
      grunt.task.run ["shell:checkAdb"]


    # Check if we have access to check_reqs.js
    checkReqsPath : ->      
      try
        p = path.resolve(process.cwd(), 'platforms/android/cordova/lib/check_reqs')                
        grunt.verbose.writeln "Try to find `check_reqs.js` at `#{p}`"

        p = require.resolve p
        grunt.verbose.ok "`check_reqs.js` found at `#{p}`"

        p
      catch


    # Run check_reqs
    run: (callback)->
      check.checkAdb callback

      p = check.checkReqsPath()
      if p
        check_reqs = require p

        success = ->
          grunt.log.ok 'Looks like your environment fully supports cordova-android development!'.bold.green
          callback()

        failure = (err)->
          grunt.log.error err.bold.red
          callback(err)

        check_reqs.run().done success, failure

      else
        msg = "Cannot find `check_reqs.js`"
        grunt.log.error msg.red
        callback msg

module.exports = r