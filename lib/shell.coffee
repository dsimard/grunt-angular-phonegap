r = (grunt)->
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

module.exports = r