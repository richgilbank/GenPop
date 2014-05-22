var gulp    = require('gulp'),
    stylus  = require('gulp-stylus'),
    nib     = require('nib'),
    concat  = require('gulp-concat'),
    coffee  = require('gulp-coffee'),
    watch   = require('gulp-watch'),
    uglify  = require('gulp-uglify'),
    debug   = require('gulp-debug'),
    connect = require('gulp-connect');

gulp.task('connect', function(){
  connect.server({
    root: 'generated',
    livereload: true
  });
});

gulp.task('vendor', function(){
  return gulp.src(['src/js/vendor/**'])
    // .pipe(debug({verbose: true}))
    .pipe(concat('vendor.js'))
    .pipe(gulp.dest('generated/js/'));
});

gulp.task('stylus', function(){
  return gulp.src(['src/css/main.styl'])
    .pipe(concat('main.styl'))
    .pipe(stylus({use: [nib()]}))
    .pipe(concat('main.css'))
    .pipe(gulp.dest('generated/css/'))
    .pipe(connect.reload());
});

gulp.task('coffee', function(){
  return gulp.src([
    'src/js/util.coffee',
    'src/js/point.coffee',
    'src/js/triangle.coffee',
    'src/js/main.coffee'
  ])
    .pipe(concat('main.coffee'))
    .pipe(coffee())
    .pipe(concat('main.js'))
    .pipe(gulp.dest('generated/js/'))
    .pipe(connect.reload());
});

gulp.task('copy', function(){
  return gulp.src(['src/**/*.{html,md}'])
    .pipe(connect.reload())
    .pipe(gulp.dest('generated/'));
});

gulp.task('watch', function(){
  gulp.watch('src/js/vendor/**/*.js', ['vendor']);
  gulp.watch('src/css/**/*.styl', ['stylus']);
  gulp.watch('src/js/**/*.coffee', ['coffee']);
  gulp.watch('src/**/*.{html,md}', ['copy']);
});

gulp.task('default', ['connect', 'vendor', 'stylus', 'coffee', 'copy', 'watch']);

