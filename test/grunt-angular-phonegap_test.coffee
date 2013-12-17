"use strict"
grunt = require("grunt")
#
#  ======== A Handy Little Nodeunit Reference ========
#  https://github.com/caolan/nodeunit
#
#  Test methods:
#    test.expect(numAssertions)
#    test.done()
#  Test assertions:
#    test.ok(value, [message])
#    test.equal(actual, expected, [message])
#    test.notEqual(actual, expected, [message])
#    test.deepEqual(actual, expected, [message])
#    test.notDeepEqual(actual, expected, [message])
#    test.strictEqual(actual, expected, [message])
#    test.notStrictEqual(actual, expected, [message])
#    test.throws(block, [error], [message])
#    test.doesNotThrow(block, [error], [message])
#    test.ifError(value)
#

grunt.loadTasks('./');

exports.phonegapgap =
  setUp: (done) ->
    
    # setup here if necessary
    done()

  # All tasks are there
  checkForTasks: (test) ->
    tasks = grunt.task._tasks

    checkTask = (task)->
      test.ok tasks[task]?, "`#{task}` is not found"

    checkTask(task) for task in ["phonegap:build", "phonegap:emulate", "phonegap:send", "phonegap:check"]

    test.done()

  # Configs are ok
  checkConfig: (test)->
    config = grunt.config.data

    test.equal 'www', config.yeoman.phonegap

    test.deepEqual ['<%= yeoman.phonegap %>/*', '!<%=yeoman.phonegap %>/config.xml', '!<%= yeoman.phonegap %>/res'], config.clean.phonegap

    test.ok config.copy.phonegap

    test.done()

  # Shells have the right command
  checkShells: (test)->
    shell = grunt.config.data.shell

    test.ok shell

    test.equal 'phonegap local build android', shell.phonegapBuild.command()
    test.equal 'phonegap local build ios', shell.phonegapBuild.command('ios')

    test.equal 'phonegap local run android --emulator &', shell.emulate.command()
    test.equal 'phonegap local run ios --emulator &', shell.emulate.command('ios')

    test.equal 'phonegap remote build android', shell.phonegapBuildRemote.command()
    test.equal 'phonegap remote build ios', shell.phonegapBuildRemote.command('ios')

    test.equal 'adb version', shell.checkAdb.command()

    test.done()