var gulp = require('gulp'),
    stylus = require('gulp-stylus'),
    concat = require('gulp-concat'),
    coffee = require('gulp-coffee'),
    watch = require('gulp-watch'),
    uglify = require('gulp-uglify');

gulp.task('js', function(){
  return gulp.src('src/js/**/*.coffee')
    .pipe(watch(function(files){
      return files
        .pipe(concat('main.coffee'))
        .pipe(coffee())
        .pipe(concat('main.js'))
        .pipe(gulp.dest('generated/js/'));
    }));
});
