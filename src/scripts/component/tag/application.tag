application(
	style="width:{ width }px;height:{ height }px"
)
	title-bar(
		width="{ width }"
		height="{ height }"
	)
	controls(
		width="{ width }"
		height="{ height }"
	)
	overray
	history(
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

		# mouse over ----------------------------------------
		timer = null
		window.addEventListener 'mouseover', (e) =>
			clearTimeout timer
			observer.trigger 'show'

			timer = setTimeout =>
				observer.trigger 'hidden'
			, 3000

		window.addEventListener 'mousemove', (e) =>
			clearTimeout timer
			observer.trigger 'show'

			timer = setTimeout =>
				observer.trigger 'hidden'
			, 3000

		window.addEventListener 'click', (e) =>
			clearTimeout timer
			observer.trigger 'show'

			timer = setTimeout =>
				observer.trigger 'hidden'
			, 3000

		# mouse out -----------------------------------------
		window.addEventListener 'mouseout',(e) =>
			observer.trigger 'hidden'