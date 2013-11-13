(function() {
  "use strict";
  module.exports = function(grunt) {
    return grunt.registerMultiTask("phonegapgap", "Grunt task for yeoman generator-phonegapgap", function() {
      var options;
      options = this.options({
        punctuation: ".",
        separator: ", "
      });
      return this.files.forEach(function(f) {
        var src;
        src = f.src.filter(function(filepath) {
          if (!grunt.file.exists(filepath)) {
            grunt.log.warn("Source file \"" + filepath + "\" not found.");
            return false;
          } else {
            return true;
          }
        }).map(function(filepath) {
          return grunt.file.read(filepath);
        }).join(grunt.util.normalizelf(options.separator));
        src += options.punctuation;
        grunt.file.write(f.dest, src);
        return grunt.log.writeln("File \"" + f.dest + "\" created.");
      });
    });
  };

}).call(this);

/*
//@ sourceMappingURL=phonegapgap.js.map
*/