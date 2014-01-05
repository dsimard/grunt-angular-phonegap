grunt = require("grunt")
sinon = require '../node_modules/sinon'
_ = require '../node_modules/underscore'

check = require('../lib/phonegap.check')(grunt)

stubGitIgnore = (lines=[])->
  sinon.stub check, "readGitignore", ->
    content = "\nfirst_line"
    content += "\n" + lines.join("\n") unless _.isEmpty(lines)
    content

exports.module = 
  setUp: (done) ->
    check.readGitignore.restore?()
    done()

  'empty .gitignore': (test)->
    stub = stubGitIgnore()
    test.equal "\nfirst_line", check.readGitignore()
    test.deepEqual 4, check.appendToGitignore().length, 'Should add all IGNORES'
    test.done()

  'half .gitignore': (test)->
    stub = stubGitIgnore(_.first(check.IGNORES, 2))
    test.equal "\nfirst_line\nplatforms/**/\nwww", check.readGitignore()
    test.deepEqual check.appendToGitignore(), ['!www/config.xml', '!www/res'],
      'Should contains the lasts two items'
    stub.restore()
    test.done()

  'full .gitignore': (test)->
    stub = stubGitIgnore(check.IGNORES)
    test.deepEqual check.appendToGitignore(), [], 'Should not add items'
    stub.restore()
    test.done()