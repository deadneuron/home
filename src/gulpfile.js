const gulp = require("gulp")
const sass = require("gulp-sass")(require("sass"))
const del = require("del")

gulp.task("styles", () => {
  return gulp
    .src("assets/styles/**/*.scss")
    .pipe(sass().on("error", sass.logError))
    .pipe(gulp.dest("./static/"))
})

gulp.task("images", () => {
  return gulp
    .src("assets/images/**/*.+(png|jpg|gif|ico|svg)")
    .pipe(gulp.dest("./static"))
})

gulp.task("scripts", () => {
  return gulp.src("assets/scripts/**/*.+(js)").pipe(gulp.dest("./static"))
})

gulp.task("fonts", () => {
  return gulp
    .src("assets/fonts/**/*.+(ttf|woff|woff2)")
    .pipe(gulp.dest("./static"))
})

gulp.task("sounds", () => {
  return gulp
    .src("assets/sounds/**/*.+(mp3|webm|json|ogg|m4a|ac3)")
    .pipe(gulp.dest("./static"))
})

gulp.task("clean", () => {
  return del(["static/main.css"])
})

gulp.task("watch", () => {
  gulp.watch("assets/styles/**/*.scss", (done) => {
    gulp.series(["clean", "styles"])(done)
  })
})

gulp.task(
  "default",
  gulp.series(["clean", "styles", "images", "scripts", "fonts", "sounds"])
)
