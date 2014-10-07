/*global module:false*/
module.exports = function(grunt) {

  grunt.initConfig({
    gruntfile: {
      src: 'Gruntfile.js'
    },
    coffee: {
     compileWithMapsDir: {
        options: {
          sourceMap: true,
          sourceMapDir: 'js/maps'
        },
        files: {
          'js/nada.js': ['js/factories.coffee']
        }
      }
    },
    watch: {
      files: 'js/*.coffee',
      tasks: [ 'coffee' ]
    }
  });

  // These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.registerTask('default', ['coffee']);

};
