play
	div.btn(onclick="{ onPlay }")
	info

	style(scoped).
		:scope {
			display: block;
			width: 410px;
			height: 40px;
			margin: 0 auto;
			margin-top: 10px;
		}
		:scope:after {
			content: "";
			display: block;
			clear: both;
		}
		:scope .btn {
			float: left;
			width: 40px;
			height: 40px;
			background-image: url(../../images/play.png);
			background-size: 45%;
			background-position: center;
			background-repeat: no-repeat;
			background-color: #444;
			border-radius: 3px;
			cursor: pointer;
		}
		:scope .btn[data-state="active"] {
			background-image: url(../../images/pause.png);
		}

	script(type="coffee").

		@active = ->
			@root.children[0].setAttribute 'data-state', 'active'

		@passive = ->
			@root.children[0].setAttribute 'data-state', ''

		# play or pause -------------------------------------
		@onPlay = (e) ->
			state = e.target.getAttribute 'data-state'

			if state is 'active'
				@passive
				youtube.pause()
			else
				@active
				youtube.play()

		# play ----------------------------------------------
		observer.on 'play', =>
			@active()

		# puase ---------------------------------------------
		observer.on 'pause', =>
			@passive()

		# mount ---------------------------------------------
		@on 'mount', ->
