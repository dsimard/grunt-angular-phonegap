path = require 'path'
_ = require '../node_modules/underscore'
gitignore = require '../lib/gitignore.coffee'
{inspect} = require 'util'

g = (grunt)->
  r =
    # The `platforms/` directory must never be deleted
    # but most not be add to git neither.
    # This will check that there's a `.gitkeep` file in the directory
    writeGitKeepInPlatforms : ->
      if r.shouldWriteGitKeepInPlatforms()
        grunt.log.warn 'No `.gitkeep` in `platforms/`, it will be created'.yellow
        grunt.file.mkdir 'platforms'
        grunt.file.write 'platforms/.gitkeep', ''
      else
        grunt.verbose.writeln "There's a `.gitkeep in `platforms/`".yellow

    shouldWriteGitKeepInPlatforms : ->
      !grunt.file.exists("platforms/.gitkeep")

  # Register `phonegap:check`
  grunt.registerTask 'phonegap:check', 'Check that your computer is ready for phonegap', (target="android")->
    done = @async()

    r.writeGitKeepInPlatforms()
    gitignore.write()

    check_reqs = require("./check_reqs")(grunt, target)
    check_reqs.run done

  r

    

module.exports = g