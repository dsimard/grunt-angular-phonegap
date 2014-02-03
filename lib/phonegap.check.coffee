path = require 'path'
_ = require '../node_modules/underscore'
{inspect} = require 'util'

g = (grunt)->
  r =
    IGNORES : ['platforms/**/'
      'www'
      '!www/config.xml'
      '!www/res'
    ]

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

    writeGitignore : ->
      linesToAppend = r.appendToGitignore()

      grunt.verbose.writeln "Lines to append : #{inspect(linesToAppend)}"

      unless _.isEmpty(linesToAppend)
        linesToAppend = linesToAppend.join "\n"
        grunt.log.ok "Writing #{inspect(linesToAppend)} to `.gitignore`"

        gitignore = r.readGitignore()
        gitignore += "\n#{linesToAppend}"
        grunt.file.write '.gitignore', gitignore
      else
        grunt.verbose.writeln 'No lines to add to `.gitignore`'.yellow

    readGitignore : ->
      gitignore = grunt.file.read '.gitignore'  

    # The ignore lines to append to .gitignore
    appendToGitignore : ->
      gitignore = r.readGitignore()

      # Flush empty lines
      gitignore = _.reject gitignore.split("\n"), (line)->
        _.isEmpty line

      # Check if there are ignored lines that are missing      
      missingLines = _.reject r.IGNORES, (line)->
        _.contains gitignore, line

  # Register `phonegap:check`
  grunt.registerTask 'phonegap:check', 'Check that your computer is ready for phonegap', (target="android")->
    done = @async()

    r.writeGitKeepInPlatforms()
    r.writeGitignore()

    check_reqs = require("./check_reqs")(grunt, target)
    check_reqs.run done

  r

    

module.exports = g