application(
	style="width:{ width }px;height:{ height }px"
)
	div#player

	style(scoped).
		:scope {
			display: block;
		}

	script(type="coffee").

		# mount ---------------------------------------------
		@on 'mount', ->
			@width  = parseInt opts.width
			@height = parseInt opts.height
			@update()

		# resize --------------------------------------------
		observer.on 'resize', =>
			@width  = parseInt opts.width
			@height = parseInt opts.height
			@update()