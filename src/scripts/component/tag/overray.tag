overray(onclick="{ onClose }")

	style(scoped).
		:scope {
			position: absolute;
			width: 100%;
			height: 100%;
			background-color: rgba(0,0,0,0.5);
			display: none;
			z-index: 9;
		}
		:scope[data-state="active"] {
			display: block;
		}

	script(type="coffee").

		# click close ---------------------------------------
		@onClose = ->
			observer.trigger 'close-menu'

		# open menu -----------------------------------------
		observer.on 'open-menu', =>
			@root.setAttribute 'data-state', 'active'

		# close menu ----------------------------------------
		observer.on 'close-menu', =>
			@root.setAttribute 'data-state', ''