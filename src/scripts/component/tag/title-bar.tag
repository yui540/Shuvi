title-bar
	div.close(onclick="{ onClose }")
	div.menu(onclick="{ onMenu }")

	style(scoped).
		:scope {
			position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 30px;
			background-color: #222;
			box-shadow: 0 0 5px #555;
			display: block;
			opacity: 0;
		}
		:scope[data-state="active"] { animation: feedin 0.3s ease 0s forwards; }
		:scope[data-state="passive"] { animation: feedout 0.3s ease 0s forwards; }
		:scope:after {
			content: "";
			display: block;
			clear: both;
		}
		:scope .close {
			position: relative;
			float: left;
			width: 30px;
			height: 30px;
			background-color: #444;
		}
		:scope .close:before,
		:scope .close:after {
			position: absolute;
			top: 14.5px;
			left: 5px;
			content: "";
			display: block;
			width: 20px;
			height: 1px;
			background-color: #E27171;
		}
		:scope .close:before { transform: rotate(45deg); }
		:scope .close:after { transform: rotate(-45deg); }
		:scope .menu {
			position: relative;
			float: right;
			width: 30px;
			height: 30px;
			background-color: #444;
		}
		:scope .menu:after,
		:scope .menu:before {
			position: absolute;
			left: 7.5px;
			content: "";
			display: block;
			width: 15px;
			height: 1px;
			background-color: #E27171;
		}
		:scope .menu:after { top: 9.5px; }
		:scope .menu:before { top: 19px; }
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

		# close ---------------------------------------------
		@onClose = ->
			ipc.send 'close'

		# menu ----------------------------------------------
		@onMenu = ->
			observer.trigger 'open-menu'

		# mount ---------------------------------------------
		@on 'mount', ->




