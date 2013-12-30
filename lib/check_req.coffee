path = require 'path'
{inspect} = require 'util'

r = (grunt)->
  grunt.registerTask 'phonegap:check', 'Check that your computer is ready for phonegap', (target="android")->
    # If win, do nothing and ask for help
    if process.platform is 'win32'
      grunt.log.error "Not available for windows".red
      grunt.log.error ["Help me improving requirements check by emailing me at", "dsimard@azanka.ca".bold].join " "
      @async()
      return

    try
      check_reqs = require("./check_reqs/#{target}")(grunt)
      check_reqs.run @async()
    catch ex
      grunt.verbose.error "Error while registering task `phonegap:check`", ex
      grunt.log.error "Can't check requirements for `#{target}`.".red
      grunt.log.error ["Help me improving requirements check by emailing me at", "dsimard@azanka.ca".bold].join " "
      @async()
    

module.exports = r