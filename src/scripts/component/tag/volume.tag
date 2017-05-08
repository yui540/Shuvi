volume
	div.volume
		div.bar(style="width:{ bar }%")
		div.picker(style="left:{ pic }px")

	style(scoped).
		:scope {
			display: block;
			float: left;
			width: 155px;
			height: 40px;
			margin-left: 10px;
		}
		:scope .volume {
			position: relative;
			width: 155px;
			height: 3px;
			background-color: #4c4c4c;
			margin-top: 18.5px;
		}
		:scope .volume .bar {
			position: absolute;
			height: 3px;
			background-color: #E27171;
		}
		:scope .volume .picker {
			position: absolute;
			top: -6px;
			width: 15px;
			height: 15px;
			border-radius: 50%;
			background-color: #ccc;
			transition: all 0.3s ease 0s;
			cursor: pointer;
		}
		:scope .volume .picker:hover {
			transform: scale(1.2);
		}

	script(type="coffee").

		##
		# 更新
		##
		@reload = ->
			volume  = youtube.getVolume()
			@bar    = volume
			@pic    = 140 * (volume / 100)
			@update()

		# load ----------------------------------------------
		observer.on 'load', =>
			@reload()

		# mount ---------------------------------------------
		@on 'mount', ->

