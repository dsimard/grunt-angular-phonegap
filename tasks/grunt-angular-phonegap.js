(function() {
  var inspect;

  inspect = require('util').inspect;

  require('../node_modules/coffee-script');

  module.exports = function(grunt) {
    require('../lib/shell')(grunt);
    require('../lib/check_req')(grunt);
    grunt.config.set(['yeoman', 'phonegap'], 'www');
    grunt.config.set(['clean', 'phonegap'], ['<%= yeoman.phonegap %>/*', '!<%=yeoman.phonegap %>/config.xml', '!<%= yeoman.phonegap %>/res']);
    grunt.config.set(['copy', 'phonegap'], {
      expand: true,
      cwd: '<%= yeoman.dist %>',
      dest: '<%= yeoman.phonegap %>',
      src: '**'
    });
    grunt.registerTask('phonegap:build', 'Build for phonegap (use `build:phonegap:[platform]` when not android)', function(target) {
      if (target == null) {
        target = "android";
      }
      return grunt.task.run(['build', 'clean:phonegap', 'copy:phonegap', "shell:phonegapBuild:" + target]);
    });
    grunt.registerTask('phonegap:emulate', 'Start the app on an emulator', function(target) {
      if (target == null) {
        target = "android";
      }
      return grunt.task.run(["shell:emulate:" + target]);
    });
    return grunt.registerTask('phonegap:send', 'Send the app for a remote build', function(target) {
      if (target == null) {
        target = "android";
      }
      return grunt.task.run(['build:phonegap', "shell:phonegapBuildRemote:" + target]);
    });
  };

}).call(this);

/*
//@ sourceMappingURL=grunt-angular-phonegap.js.map
*/