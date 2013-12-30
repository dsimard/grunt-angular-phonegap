{inspect} = require 'util'
require '../node_modules/coffee-script'

module.exports = (grunt)->
  require('../lib/shell')(grunt)
  require('../lib/check_req')(grunt)

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
    src: '**'

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

