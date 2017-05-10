title-bar
	div.close(onclick="{ onClose }")

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
		}
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
			background-color: #333;
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

	script(type="coffee").

		# close ---------------------------------------------
		@onClose = ->
			ipc.send 'close'

		# mount ---------------------------------------------
		@on 'mount', ->




