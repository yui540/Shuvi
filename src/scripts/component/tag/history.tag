history(
	style="height:{ height }px"
)

	style(scoped).
		:scope {
			position: absolute;
			top: 0;
			right: -200px;
			display: block;
			width: 200px;
			background-color: #222;
			z-index: 10;
		}
		:scope[data-state="active"] { animation: show 0.3s ease 0s forwards; }
		:scope[data-state="passive"] { animation: hidden 0.3s ease 0s forwards; }
		@keyframes show {
			0%   { right: -200px; }
			100% { right: 0px; }
		}
		@keyframes hidden {
			0%   { right: 0px; }
			100% { right: -200px; }
		}

	script(type="coffee").

		# mount ---------------------------------------------
		@on 'mount', ->
			@height = parseInt opts.height
			@update()

		# resize --------------------------------------------
		observer.on 'resize', (params) =>
			@height = params.height
			@update()

		# open menu -----------------------------------------
		observer.on 'open-menu', =>
			@root.setAttribute 'data-state', 'active'

		# close menu -----------------------------------------
		observer.on 'close-menu', =>
			@root.setAttribute 'data-state', 'passive'

