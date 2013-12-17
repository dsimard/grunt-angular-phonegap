#
# * grunt-angular-phonegap
# * https://github.com/dsimard/grunt-angular-phonegap
# *
# * Copyright (c) 2013 dsimard
# * Licensed under the MIT license.
# 
"use strict"
module.exports = (grunt) ->
  
  # Project configuration.
  grunt.initConfig
    coffee:
      src:
        options:
          sourceMap: true
        expand: true
        cwd: "src"
        src: ["{,**}/*.coffee"]
        dest: "tasks/"
        ext: ".js"

    watch:
      coffee:
        files: ["{src,lib}/{,**}/*.coffee"]
        tasks: ["coffee:src"]

      test:
        files: ["{test,tasks}/{,**}/*.{js,coffee}"]
        tasks: ["test"]

    jshint:
      all: ["Gruntfile.js", "tasks/*.js", "<%= nodeunit.tests %>"]
      options:
        jshintrc: ".jshintrc"

    
    # Before generating any new files, remove any previously-created files.
    clean:
      tests: ["tmp"]

    
    # Unit tests.
    nodeunit:
      tests: ["test/*_test.coffee"]

    
    # Changelog
    changelog:
      options: 
        github: 'dsimard/grunt-angular-phonegap'

  
  # Actually load this plugin's task(s).
  grunt.loadTasks "tasks"
  
  # These plugins provide necessary tasks.
  grunt.loadNpmTasks "grunt-contrib-jshint"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-nodeunit"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-release"
  grunt.loadNpmTasks "grunt-conventional-changelog"
  
  # Whenever the "test" task is run, first clean the "tmp" dir, then run this
  # plugin's task(s), then test the result.
  grunt.registerTask "test", ["clean", "nodeunit"]
  
  # By default, lint and run all tests.
  grunt.registerTask "default", ["jshint", "test"]
  
  # Add a deploy task
  grunt.registerTask "deploy", "Build and release", (target) ->
    target = target or "patch"
    grunt.task.run ["coffee", "changelog", "release:" + target]
