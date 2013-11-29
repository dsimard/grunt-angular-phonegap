{inspect} = require 'util'

module.exports = (grunt)->
  grunt.config.set ['yeoman', 'phonegap'], 'www'

  grunt.config.set ['clean', 'phonegap'], ['<%= yeoman.phonegap %>/*', '!<%=yeoman.phonegap %>/config.xml', '!<%= yeoman.phonegap %>/res']

  grunt.config.set ['copy', 'phonegap'],
    expand: true,
    cwd: '<%= yeoman.dist %>',
    dest: '<%= yeoman.phonegap %>',
    src: '**'

  grunt.config.set ['shell', 'phonegapBuild'], 
    command: (target="android")->
      grunt.log.subhead "Building for #{target}"
      "phonegap local build #{target}"
    options:
      stdout: true

  grunt.config.set ['shell', 'emulate'], 
    command: (target="android")->
      "phonegap local run #{target} --emulator &"
    options:
      stdout: true

  grunt.config.set ['shell', 'phonegapBuildRemote'], 
    command: (target="android")->
      grunt.log.subhead "Building remotely for #{target}"
      "phonegap remote build #{target}"
    options:
      stdout: true

  grunt.registerTask 'build:phonegap', 'Build for phonegap (use `build:phonegap:[platform]` when not android)', (target="android")->
    grunt.task.run ['build', 'clean:phonegap', 'copy:phonegap', "shell:phonegapBuild:#{target}"]

  grunt.registerTask 'phonegap:emulate', 'Start the app on an emulator', (target="android")->
    grunt.task.run ["shell:emulate:#{target}"]

  grunt.registerTask 'phonegap:send', 'Send the app for a remote build', (target="android")->
    grunt.task.run ['build:phonegap', "shell:phonegapBuildRemote:#{target}"]