gitignore = require '../lib/gitignore'
gitkeep = require '../lib/platforms_gitkeep'

g = (grunt)->
  # Register `phonegap:check`
  grunt.registerTask 'phonegap:check', 'Check that your computer is ready for phonegap', (target="android")->
    done = @async()

    gitkeep.write()
    gitignore.write()

    check_reqs = require("./check_reqs")(grunt, target)
    check_reqs.run done

    

module.exports = g