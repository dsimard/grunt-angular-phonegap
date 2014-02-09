grunt = require("grunt")

gitkeep = require('../lib/platforms_gitkeep')(grunt)

exports.module = 
  setUp: (done) ->
    done()

  'should write .gitkeep in platforms': (test)->
    test.ok gitkeep.shouldWrite()
    test.done()