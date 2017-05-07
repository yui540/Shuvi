seek
	div.current { current }
	div.seek
		div.load
		div.bar
		div.picker
	div.duration { duration }

	style(scoped).
		:scope {
			width: 410px;
			height: 20px;
			display: block;
			margin: 0 auto;
			margin-top: 10px;
		}
		:scope:after {
			content: "";
			display: block;
			clear: both;
		}
		:scope .current,
		:scope .duration {
			float: left;
			width: 40px;
			height: 20px;
			font-size: 10px;
			color: #ccc;
			text-align: center;
			line-height: 20px;
			border-radius: 3px;
		}
		:scope .seek {
			position: relative;
			float: left;
			width: 330px;
			height: 5px;
			background-color: #4c4c4c;
			margin-top: 7.5px;
		}
		:scope .seek .bar {
			position: absolute;
			top: 0;
			left: 0;
			width: 20%;
			height: 5px;
			background-color: #E27171;
		}
		:scope .seek .load {
			position: absolute;
			top: 0;
			left: 0;
			width: 30%;
			height: 5px;
			background-color: #777;
		}

	script(type="coffee").

		# mount ---------------------------------------------
		@on 'mount', ->
			@current  = '0:00'
			@duration = '0:00'
			@update()