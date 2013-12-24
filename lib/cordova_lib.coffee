path = require 'path'

# Load librairies from `platforms/[platform]/cordova/lib`
module.exports = (grunt)->
  r =
    rawPath : (name, platform="android")->
      p = path.resolve(process.cwd(), "platforms/#{platform}/cordova/lib/#{name}")
      grunt.verbose.writeln "RawPath :", p
      p

    exist : (name, platform="android")->
      r.path(name, platform)?

    path : (name, platform="android")->
      grunt.verbose.writeln "Path for : ", platform, name

      p = r.rawPath name, platform
      grunt.verbose.writeln "Try to find `#{name}` at `#{p}`"
      try
        p = require.resolve p
        grunt.verbose.ok "`#{name}` found at `#{p}`"
        return p 
      catch ex
        grunt.verbose.writeln "Error when looking for path for : ", platform, name
        grunt.verbose.error ex
        return

    req : (name, platform="android")->
      grunt.verbose.writeln "Require cordova lib : ", platform, name
      p = r.path(name, platform)

      require(p) if p?