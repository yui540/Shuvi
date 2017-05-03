gulp    = require 'gulp'
uglify  = require 'gulp-uglify'
coffee  = require 'gulp-coffee'
riot    = require 'gulp-riot'
jade    = require 'gulp-jade'
plumber = require 'gulp-plumber'

gulp.task 'riot', ->
	gulp.src 'src/scripts/component/tag/*.tag'
		.pipe plumber()
		.pipe riot
			compact  : true
			type     : 'coffeescript'
			template : 'jade'
		.pipe gulp.dest 'src/scripts/component/js'

gulp.task 'jade', ['riot'], ->
	gulp.src 'src/views/jade/*.jade'
		.pipe plumber()
		.pipe jade()
		.pipe gulp.dest 'src/views/html'

gulp.task 'coffee', ['jade'], ->
	gulp.src 'src/bin/coffee/*.coffee'
		.pipe plumber()
		.pipe coffee()
		.pipe uglify()
		.pipe gulp.dest 'src/bin/js'

gulp.task 'default', ['riot', 'jade', 'coffee']
gulp.task 'watch', ->
	gulp.watch [
			'src/scripts/component/tag/*.tag'
			'src/views/jade/*.jade'
			'src/bin/coffee/*.coffee'
		], ['riot', 'jade', 'coffee']