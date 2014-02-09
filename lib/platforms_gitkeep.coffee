# The `platforms/` directory must never be deleted
# but most not be add to git neither.
# This will check that there's a `.gitkeep` file in the directory
_ = require '../node_modules/underscore'

g = (grunt)->
  r =
    write : ->
      if r.shouldWrite()
        grunt.log.warn 'No `.gitkeep` in `platforms/`, it will be created'.yellow
        grunt.file.mkdir 'platforms'
        grunt.file.write 'platforms/.gitkeep', ''
      else
        grunt.verbose.writeln "There's a `.gitkeep in `platforms/`".yellow

    shouldWrite : ->
      !grunt.file.exists("platforms/.gitkeep")

module.exports = g