seek
	div.current { current }
	div.seek(onclick="{ onSeek }")
		div.load(style="width:{ load * 100 }%")
		div.bar(style="width:{ bar * 100 }%")
		div.picker(
			style="left:{ pic }px"
			onmousedown="{ onMouseDown }"
		)
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
			width: 50px;
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
			width: 310px;
			height: 5px;
			background-color: #4c4c4c;
			margin-top: 7.5px;
		}
		:scope .seek .bar {
			position: absolute;
			top: 0;
			left: 0;
			height: 5px;
			background-color: #E27171;
		}
		:scope .seek .load {
			position: absolute;
			top: 0;
			left: 0;
			height: 5px;
			background-color: #777;
		}
		:scope .seek .picker {
			position: absolute;
			top: -6.5px;
			width: 8px;
			height: 20px;
			background-color: #E27171;
			border-radius: 2px;
			cursor: pointer;
		}
		:scope .seek .picker:hover {
			transform: scale(1.2);
		}

	script(type="coffee").

		##
		# 時間の変換
		# @param time : 時間
		# @return str
		##
		@castTime = (time) ->
			# 秒
			str = parseInt time % 60
			str = @strTime str

			# 分
			seconds = parseInt time / 60
			seconds = @strTime seconds
			str     = seconds + ':' + str

			# 時
			if (time / 3600) >= 1
				hours = parseInt time / 3600
				hours = @strTime hours
				str   = hours + ':' + str

			return str

		##
		# 文字列化
		##	
		@strTime = (time) ->
			if time >= 60
				time -= 60

			if time < 10
				return '0' + time
			else
				return time

		##
		# シークバーの更新
		##
		@reload = ->
			buffer   = youtube.buffer()
			current  = youtube.current()
			duration = youtube.duration()

			@current  = @castTime current
			@duration = @castTime duration
			@load     = buffer
			@bar      = current / duration
			@pic      = 302 * @bar

			@update()

		# mount ---------------------------------------------
		@on 'mount', ->
			@load     = 0
			@bar      = 0
			@pic      = 0
			@current  = '0:00'
			@duration = '0:00'
			@update()

		# load ----------------------------------------------
		observer.on 'load', =>
			@reload()

		# seek ----------------------------------------------
		observer.on 'seek', =>
			@reload()

		# on seek -------------------------------------------
		@onSeek = (e) ->
			left = @root.children[1].getBoundingClientRect().left
			x    = e.clientX - left

			@root.children[1].children[2].style.left  = x + 'px'
			@root.children[1].children[1].style.width = (x / 302 * 100) + '%'
			youtube.seek x / 302
			@reload()

		# mouse down ----------------------------------------
		down = false
		@onMouseDown = (e) ->
			down = true

		# mouse move ----------------------------------------
		window.addEventListener 'mousemove', (e) =>
			if not down
				return 

			left = @root.children[1].getBoundingClientRect().left
			x    = e.clientX - left

			if x < 0
				x = 0
			else if x > 302
				x = 302

			@root.children[1].children[2].style.left  = x + 'px'
			@root.children[1].children[1].style.width = (x / 302 * 100) + '%'
			youtube.seek x / 302
			@reload()

		# mouse up ------------------------------------------
		window.addEventListener 'mouseup', (e) =>
			down = false

