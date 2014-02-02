{inspect} = require 'util'

r = (grunt, target)->
  cordovaLib = require('./cordova_lib')(grunt, target)

  check =
    # Run check_reqs
    run: (callback)->
      grunt.verbose.writeln "Calling `shell:checkAdb`"
      grunt.task.run ["shell:checkAdb"]

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
        msg = "Cannot find `check_reqs.js`, probably you didn't add the platform."
        msg += "Run `cordova platform add android`"
        grunt.log.error msg.red
        callback msg

module.exports = r