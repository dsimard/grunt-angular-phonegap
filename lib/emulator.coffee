_ = require '../node_modules/underscore'

module.exports = (grunt, target)->
  if target isnt 'android'
    grunt.log.error "Not available for #{target}".red
    grunt.log.error ["Help me improving this project by emailing me at", "dsimard@azanka.ca".bold].join " "

  # Load emulator from cordova
  emulator = require('./cordova_lib')(grunt).req "emulator"

  r =
    # Start the emulator
    emulate : ->
      grunt.task.run ["shell:emulate:#{target}"]

    # List all running emulators
    list : ->
      # TODO : call cordova `emulator.list`
      []

    # Return the command for shell
    shellCommand : (emulator=null)->
      emulators = r.list()

      # Start an emulator if none is running
      if _.isEmpty(emulators)
        "phonegap local run #{target} --emulator &"
      else
        unless emulator?
          # Use the first one
          "phonegap install --emulator=#{_.first(emulators)} #{target}"
        else
          # Use the specified one
          "phonegap install --emulator=#{emulator} #{target}"


