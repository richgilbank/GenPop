var gulp = require('gulp'),
    stylus = require('gulp-stylus'),
    nib = require('nib'),
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

gulp.task('vendor', function(){
  return gulp.src(['src/js/vendor/**/*.js'])
    .pipe(watch(function(files){
      return files
        .pipe(concat('vendor.js'))
        .pipe(gulp.dest('generated/js/'))
        .pipe(connect.reload());
    }));
});

gulp.task('stylus', function(){
  return gulp.src(['src/css/**/*.styl'])
    .pipe(watch(function(files){
      return gulp.src(['src/css/main.styl'])
        .pipe(concat('main.styl'))
        .pipe(stylus({use: [nib()]}))
        .pipe(concat('main.css'))
        .pipe(gulp.dest('generated/css/'))
        .pipe(connect.reload());
    }));
});

gulp.task('coffee', function(){
  return gulp.src(['src/js/main.coffee', 'src/js/**/*.coffee'])
    .pipe(watch(function(files){
      return files
        // .pipe(concat('main.coffee'))
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

gulp.task('default', ['connect', 'vendor', 'stylus', 'coffee', 'copy']);

