# `.gitignore` should have some lines to not commit
# everthing in the `platforms` directory. This module
# takes care of that.

_ = require '../node_modules/underscore'

fct = (grunt)->
  r =
    # Lines that should be in the file
    LINES : ['platforms/**/'
      'www'
      '!www/config.xml'
      '!www/res'
    ]

    # Read the `.gitignore` file
    read : ->
      grunt.file.read '.gitignore'

    # Read `.gitignore` as array
    readAsArray : ->
      gitignore = r.read()

      # Flush empty lines
      _.reject gitignore.split("\n"), (line)->
        _.isEmpty line

    # Returns the missing lines
    missingLines : ->
      gitignore = r.readAsArray()

      _.reject r.LINES, (line)->
        _.contains gitignore, line

    # Check if there are one or more lines missing in `.gitignore`
    someLinesAreMissing : ->
      r.missingLines.length > 0

    # Write missing lines
    append : ->
      if r.someLinesAreMissing()
        grunt.log.warn ["Some lines are missing to `.gitignore`,", "they will be written".bold].join(" ").yellow
        linesToAppend = r.missingLines()
        linesToAppend = linesToAppend.join "\n"
        grunt.log.ok "Writing #{inspect(linesToAppend)} to `.gitignore`"

        gitignore = r.readGitignore()
        gitignore += "\n#{linesToAppend}"
        grunt.file.write '.gitignore', gitignore
      else
        grunt.verbose.writeln "`.gitignore` is OK"

module.exports = fct