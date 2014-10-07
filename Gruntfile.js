/*global module:false*/
module.exports = function(grunt) {

  grunt.initConfig({
    gruntfile: {
      src: 'Gruntfile.js'
    },
    coffee: {
     compileWithMaps: {
        options: {
          sourceMap: true,
        },
        files: {
          'js/nada.js': ['js/factories.coffee']
        }
      }
    },
    sass: {
      dist: {
        files: {
          'css/app.css': 'css/app.scss'
        }
      }
    },
    watch: {
      files: [
        'js/*.coffee',
        'css/*.scss',
        'css/*.sass'
      ],
      tasks: [
        'coffee',
        'sass'
      ]
    }
  });

  // These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.registerTask('default', ['coffee', 'sass']);

};
