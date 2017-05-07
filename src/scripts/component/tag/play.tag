play
	div.btn(onclick="{ onPlay }")

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
		}

	script(type="coffee").

		##
		#  
		##
		@onPlay = ->
			youtube.play()

		# mount ---------------------------------------------
		@on 'mount', ->
