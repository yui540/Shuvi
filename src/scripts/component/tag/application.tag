application(
	style="width:{ width }px;height:{ height }px"
)
	title-bar
	controls(
		width="{ width }"
		height="{ height }"
	)

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