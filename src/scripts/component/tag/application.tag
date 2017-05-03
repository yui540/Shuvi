application(
	style="width:{ width }px;height:{ height }px"
)
	div#player

	style(scoped).
		:scope {
			position: absolute;
			top: 0;
			left: 0;
			display: block;
		}

	script(type="coffee").

		# mount ---------------------------------------------
		@on 'mount', ->
			@width  = parseInt opts.width
			@height = parseInt opts.height
			@update()

		# resize --------------------------------------------
		observer.on 'resize', (params) =>
			@width  = params.width
			@height = params.height
			@update()

		#&controls=0&loop=1&showinfo=0