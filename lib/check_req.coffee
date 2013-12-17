path = require 'path'
{inspect} = require 'util'

r = (grunt)->
  grunt.registerTask 'phonegap:check', 'Check that your computer is ready for phonegap', (target="android")->
    # If win, do nothing and ask for help
    return if process.platform is 'win32'

    try
      check_reqs = require("./check_reqs/#{target}")(grunt)
      check_reqs.run @async()
    catch
      grunt.log.error "Can't check requirements for `#{target}`.".red
      grunt.log.error ["Help me improving requirement checks by emailing me at", "dsimard@azanka.ca".bold].join " "
    

module.exports = r