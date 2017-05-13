history(
	style="height:{ height }px"
)
	div.li(
		each="{ history }"
		data-state="{ state }"
		data-id="{ id }"
		onclick="{ onSelect }"
	)
		div.thumb(style="background-image:url({ thumb })")
		div.title { title }

	style(scoped).
		:scope {
			position: absolute;
			top: 0;
			right: -301px;
			display: block;
			width: 300px;
			background-color: #222;
			overflow: auto;
			border-left: solid 1px #c85399;
			z-index: 10;
		}
		:scope[data-state="active"] { animation: show 0.3s ease 0s forwards; }
		:scope[data-state="passive"] { animation: hidden 0.3s ease 0s forwards; }
		@keyframes show {
			0%   { right: -301px; }
			100% { right: 0px; }
		}
		@keyframes hidden {
			0%   { right: 0px; }
			100% { right: -301px; }
		}
		:scope .li {
			width: 280px;
			height: 45px;
			background-color: #444;
			margin: 10px auto;
			overflow: hidden;
			border-radius: 3px;
			cursor: pointer;
		}
		:scope .li[data-state="true"] {
			background-color: #c85399;
		}
		:scope .li[data-state="true"] .title {
			color: #fff;
		}
		:scope .li:after {
			content: "";
			display: block;
			clear: both;
		}
		:scope .li .thumb {
			float: left;
			width: 80px;
			height: 45px;
			background-size: cover;
			background-position: center;
		}
		:scope .li .title {
			float: right;
			width: 200px;
			height: 45px;
			font-size: 10px;
			padding: 0 5px;
			box-sizing: border-box;
			color: #ccc;
			line-height: 45px;
			white-space: nowrap;
		}

	script(type="coffee").

		##
		# 履歴更新
		##
		@reload = ->
			id      = localStorage['id']
			history = JSON.parse localStorage['history']
			for val, i in history
				if val.id is id
					history[i].state = true
				else
					history[i].state = false

			@history = history

		# mount ---------------------------------------------
		@on 'mount', ->
			@height = parseInt opts.height
			@reload()
			@update()

		# resize --------------------------------------------
		observer.on 'resize', (params) =>
			@height = params.height
			@update()

		# select --------------------------------------------
		@onSelect = (e) ->
			id = e.path[1].getAttribute 'data-id'
			youtube.getInfo id, (params) =>
				youtube.change params.id

		# load ----------------------------------------------
		observer.on 'load', =>
			@reload()
			@update()

		# open menu -----------------------------------------
		observer.on 'open-menu', =>
			@root.setAttribute 'data-state', 'active'

		# close menu -----------------------------------------
		observer.on 'close-menu', =>
			@root.setAttribute 'data-state', 'passive'

