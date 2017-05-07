controls(
	style="left:{ left }px"
)
	seek
	play

	style(scoped).
		:scope {
			position: absolute;
			bottom: 10px;
			display: block;
			width: 430px;
			height: 90px;
			background-color: #222;
			box-shadow: 0 0 5px #555;
			border-radius: 5px;
			box-sizing: border-box;
		}

	script(type="coffee").

		# mount ---------------------------------------------
		@on 'mount', ->
			width  = parseInt opts.width
			height = parseInt opts.height
			@left  = (width - 430) / 2

			@update()

		# resize --------------------------------------------
		observer.on 'resize', (params) =>
			width  = params.width
			height = params.height
			@left  = (width - 430) / 2

			@update()