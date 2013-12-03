/*
 * grunt-angular-phonegap
 * https://github.com/dsimard/grunt-angular-phonegap
 *
 * Copyright (c) 2013 dsimard
 * Licensed under the MIT license.
 */

'use strict';

module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    coffee: {
      options:{
        sourceMap: true
      },
      compileTasks: {         
        expand: true,
        cwd: 'src',
        src: ['{,**}/*.coffee'],
        dest: 'tasks/',
        ext: '.js'
      }
    },
    watch: {
      coffee: {
        files: ['src/{,**}/*.coffee'],
        tasks: ['coffee']
      },
      test: {
        files: ['{test,tasks}/{,**}/*.js'],
        tasks: ['test']
      }
    },
    jshint: {
      all: [
        'Gruntfile.js',
        'tasks/*.js',
        '<%= nodeunit.tests %>',
      ],
      options: {
        jshintrc: '.jshintrc',
      },
    },

    // Before generating any new files, remove any previously-created files.
    clean: {
      tests: ['tmp'],
    },

    // Configuration to be run (and then tested).
    "angular-phonegap": {
      default_options: {
        options: {
        },
        files: {
          'tmp/default_options': ['test/fixtures/testing', 'test/fixtures/123'],
        },
      },
      custom_options: {
        options: {
          separator: ': ',
          punctuation: ' !!!',
        },
        files: {
          'tmp/custom_options': ['test/fixtures/testing', 'test/fixtures/123'],
        },
      },
    },

    // Unit tests.
    nodeunit: {
      tests: ['test/*_test.js'],
    },

  });

  // Actually load this plugin's task(s).
  grunt.loadTasks('tasks');

  // These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-nodeunit');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-release');

  // Whenever the "test" task is run, first clean the "tmp" dir, then run this
  // plugin's task(s), then test the result.
  grunt.registerTask('test', ['clean', 'angular-phonegap', 'nodeunit']);

  // By default, lint and run all tests.
  grunt.registerTask('default', ['jshint', 'test']);

  // Add a deploy to
  grunt.registerTask('deploy', 'Build and release', function(target) {
    target = target || "patch"
    grunt.task.run(['coffee', 'release:'+target]);
  });

};
