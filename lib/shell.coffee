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

  # Register the task that returns the ADB version for android
  checkAdb = (err, stdout, sterr, cb)->
    if err
      grunt.log.error "`adb` is not in your PATH variable environment (see https://github.com/dsimard/grunt-angular-phonegap/issues/9)".red 
    else
      grunt.verbose.ok "`adb` is installed : #{stdout}"

    cb?()

  grunt.config.set ['shell', 'checkAdb'], 
    command: (target="android")->
      "adb version"
    options:
      callback: checkAdb

module.exports = r