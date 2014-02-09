grunt = require("grunt")
sinon = require '../node_modules/sinon'
_ = require '../node_modules/underscore'

gitignore = require('../lib/gitignore')(grunt)

stubGitIgnore = (lines=[])->
  sinon.stub gitignore, "read", ->
    content = "\nfirst_line"
    content += "\n" + lines.join("\n") unless _.isEmpty(lines)
    content

exports.module = 
  setUp: (done) ->
    gitignore.read.restore?()
    done()

  'empty .gitignore': (test)->
    stub = stubGitIgnore()
    test.equal "\nfirst_line", gitignore.read()
    test.equal 4, gitignore.missingLines().length
    test.done()

  'half .gitignore': (test)->
    stub = stubGitIgnore(_.first(gitignore.LINES, 2))
    test.equal "\nfirst_line\nplatforms/**/\nwww", gitignore.read()
    test.equal 2, gitignore.missingLines().length
    stub.restore()
    test.done()

  'full .gitignore': (test)->
    stub = stubGitIgnore(gitignore.LINES)
    test.deepEqual gitignore.missingLines(), [], 'Should not add items'
    stub.restore()
    test.done()