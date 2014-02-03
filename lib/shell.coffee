r = (grunt)->
  # Initialize a variable for the `checkAdb` callback
  # TODO : this is not clean
  _target = "" 

  grunt.config.set ['shell', 'phonegapBuild'], 
    command: (target="android")->
      grunt.log.subhead "Building for #{target}"
      "phonegap local build #{target}"
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
    if process.platform is 'win32'
      grunt.log.warn "`grunt phonegap:checkAdb` is not working on Windows"
      grunt.log.warn ["Help me improving `checkAdb` by emailing me at", "dsimard@azanka.ca".bold].join " "
      return cb?()

    if _target isnt "android"
      grunt.log.warn "`grunt phonegap:checkAdb` is Android only".yellow
      return cb?()

    if err
      grunt.log.writeln "`adb` is not in your PATH variable environment (see https://github.com/dsimard/grunt-angular-phonegap/issues/9)".red 
    else
      grunt.verbose.ok "`adb` is installed : #{stdout}"

    cb?()

  grunt.config.set ['shell', 'checkAdb'], 
    command: (target="android")->
      _target = target
      if target is "android"
        "adb version" 
      else
        ""

    options:
      callback: (checkAdb)

module.exports = r