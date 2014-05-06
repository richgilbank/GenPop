var gulp = require('gulp'),
    stylus = require('gulp-stylus'),
    concat = require('gulp-concat'),
    coffee = require('gulp-coffee'),
    watch = require('gulp-watch'),
    uglify = require('gulp-uglify'),
    connect = require('gulp-connect');

gulp.task('connect', function(){
  connect.server({
    root: 'generated',
    livereload: true
  });
});

gulp.task('js', function(){
  return gulp.src(['src/js/main.coffee', 'src/js/**/*.coffee'])
    .pipe(watch(function(files){
      return files
        .pipe(concat('main.coffee'))
        .pipe(coffee())
        .pipe(concat('main.js'))
        .pipe(gulp.dest('generated/js/'))
        .pipe(connect.reload());
    }));
});

gulp.task('copy', function(){
  return gulp.src(['src/**/*.{html,md}'])
    .pipe(watch(function(files){
      return files
        .pipe(connect.reload())
        .pipe(gulp.dest('generated/'));
    }));
});

gulp.task('default', ['js', 'copy', 'connect']);

