volume
	div.icon1
	div.volume
		div.bar(style="width:{ bar }%")
		div.picker(
			style="left:{ pic }px"
			onmousedown="{ onMousedown }"
		)
	div.icon2

	style(scoped).
		:scope {
			display: block;
			float: left;
			width: 155px;
			height: 40px;
			margin-left: 10px;
		}
		:scope .icon1,
		:scope .icon2 {
			float: left;
			width: 20px;
			height: 40px;
			background-position: center;
			background-repeat: no-repeat;
			background-size: 80% auto;
		}
		:scope .icon1 { background-image: url(../../images/volume_min.png); }
		:scope .icon2 { background-image: url(../../images/volume_max.png); }
		:scope .volume {
			float: left;
			position: relative;
			width: 115px;
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
			@pic    = 100 * (volume / 100)
			@update()

		# load ----------------------------------------------
		observer.on 'load', =>
			@reload()

		# mount ---------------------------------------------
		@on 'mount', ->

		# mouse down ----------------------------------------
		down = false
		@onMousedown = (e) ->
			down = true

		# mouse move ----------------------------------------
		window.addEventListener 'mousemove', (e) =>
			if not down
				return

			left = @root.children[1].getBoundingClientRect().left
			x    = e.clientX - left

			if x < 0
				x = 0
			else if x > 100
				x = 100

			youtube.setVolume x
			@reload()

		# mouse up ------------------------------------------
		window.addEventListener 'mouseup', (e) =>
			down = false

			



