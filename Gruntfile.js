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
          'js/background.js': ['js/coffee/background.coffee'],
          'js/nada.js': [
            'js/coffee/box.coffee',
            'js/coffee/positioner.coffee',
            'js/coffee/skin.coffee',
            'js/coffee/message.coffee',
            'js/coffee/truth.coffee',
            'js/coffee/mask.coffee',
            'js/coffee/glasses.coffee',
            'js/coffee/debug.coffee'
            ]
        }
      }
    },
    sass: {
      dist: {
        files: {
          'css/app.css': 'css/scss/app.scss'
        }
      }
    },
    watch: {
      files: [
        'js/coffee/*.coffee',
        'css/scss/*.scss',
        'css/sass/*.sass'
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
