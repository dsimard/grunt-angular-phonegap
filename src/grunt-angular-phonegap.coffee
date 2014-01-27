{inspect} = require 'util'
require '../node_modules/coffee-script'
_ = require '../node_modules/underscore'

module.exports = (grunt)->
  @initAngularPhonegapConfig = ->
    # Add stuff from grunt-angular-phonegap
    require('../lib/shell')(grunt)
    require('../lib/phonegap.check')(grunt)

    grunt.config.set ['yeoman', 'phonegap'], 'www'

    grunt.config.set ['clean', 'phonegap'], 
      [
        '<%= yeoman.phonegap %>/*'
        '!<%=yeoman.phonegap %>/config.xml'
        '!<%= yeoman.phonegap %>/res'
      ]

    grunt.config.set ['copy', 'phonegap'],
      expand: true,
      cwd: '<%= yeoman.dist %>',
      dest: '<%= yeoman.phonegap %>',
      src: (->
        grunt.verbose.writeln "Do not copy `bower_components` = #{grunt.option('bower') == false}".yellow
        sources = ['**']
        sources.push ['!bower_components/**'] if grunt.option('bower') == false
        sources
        )()

    grunt.registerTask 'phonegap:build', 'Build for phonegap (use `build:phonegap:[platform]` when not android)', (target="android")->
      grunt.task.run ['build', 'clean:phonegap', 'copy:phonegap', "shell:phonegapBuild:#{target}"]
    
    grunt.registerTask 'phonegap:emulate', 
      'Start the app on an emulator (use --emulator=emulator-name to specify one)', 
      (target="android")->
        # Send to the emulator
        emulator = require('../lib/emulator')(grunt, target)
        emulator.emulate grunt.option('emulator'), @async()

    grunt.registerTask 'phonegap:send', 'Send the app for a remote build', (target="android")->
      grunt.task.run ['build:phonegap', "shell:phonegapBuildRemote:#{target}"]


  # If `grunt.config.data` is empty (meaning `grunt.initConfig` wasn't called yet) 
  # override `grunt.initConfig` so I can init `grunt-angular-phonegap`
  if _.isEmpty(grunt.config.data)
    grunt.verbose.writeln "Call grunt-angular-phonegap initialization #{"LATER".green.bold}"

    # Keep the original initConfig
    originalInitConfig = grunt.initConfig

    # Override `initConfig` for `load-grunt-tasks` to automatically
    # load stuff from `grunt-angular-phonegap`
    grunt.initConfig = (options)->
      grunt.verbose.writeln("Calling original `initConfig`".bold)
      originalInitConfig(options)
      @initAngularPhonegapConfig()

  else
    grunt.verbose.writeln "Call grunt-angular-phonegap initialization #{"NOW".green.bold}"
    @initAngularPhonegapConfig()