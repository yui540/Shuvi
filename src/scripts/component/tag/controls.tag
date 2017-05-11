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
			-webkit-app-region: no-drag;
			opacity: 0;
		}
		:scope[data-state="active"] { animation: feedin 0.3s ease 0s forwards; }
		:scope[data-state="passive"] { animation: feedout 0.3s ease 0s forwards; }
		@keyframes feedin {
			0%   { opacity: 0; }
			100% { opacity: 1; }
		}
		@keyframes feedout {
			0%   { opacity: 1; }
			100% { opacity: 0; }
		}

	script(type="coffee").

		# show ----------------------------------------------
		observer.on 'show', =>
			@root.setAttribute 'data-state', 'active'

		# hidden --------------------------------------------
		observer.on 'hidden', =>
			@root.setAttribute 'data-state', 'passive'

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