title-bar
	div.close(onclick="{ onClose }")
	div.inner(style="width:{ width - 60 }px")
		div.form
			input#movie-url(type="text", placeholder="YouTubeの動画URLを入力してください。")
			div#submit(onclick="{ onSubmit }")
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
		:scope .inner {
			float: left;
			height: 30px;
		}
		:scope .inner .form {
			width: 390px;
			height: 30px;
			margin: 0 auto;
			background-color: #333;
			-webkit-app-region: no-drag;
		}
		:scope .inner .form:after {
			content: "";
			display: block;
			clear: both;
		}
		:scope .inner .form #movie-url {
			float: left;
			width: 350px;
			height: 30px;
			font-size: 11px;
			color: #c85399;
			background-color: transparent;
			padding: 0 10px;
			box-sizing: border-box;
		}
		:scope .inner .form #movie-url::-webkit-input-placeholder {
			color: #999;
		}
		:scope .inner .form #movie-url:focus {
			outline: none;
		}
		:scope .inner .form #submit {
			float: right;
			width: 40px;
			height: 30px;
			background-image: url(../../images/submit.png);
			background-position: center;
			background-size: auto 60%;
			background-repeat: no-repeat;
		}
		:scope .close {
			position: relative;
			float: left;
			width: 30px;
			height: 30px;
			-webkit-app-region: no-drag;
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
			background-color: #c85399;
		}
		:scope .close:before { transform: rotate(45deg); }
		:scope .close:after { transform: rotate(-45deg); }
		:scope .menu {
			position: relative;
			float: right;
			width: 30px;
			height: 30px;
			-webkit-app-region: no-drag;
		}
		:scope .menu:after,
		:scope .menu:before {
			position: absolute;
			left: 7.5px;
			content: "";
			display: block;
			width: 15px;
			height: 1px;
			background-color: #c85399;
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

		# submit --------------------------------------------
		@onSubmit = ->
			url = @root.children[1].children[0].children[0].value
			url = url.replace /(\s|<|>)+/g, ''

			@root.children[1].children[0].children[0].value = ''

			id = youtube.getId url
			if not id
				alert 'URLが不正です。'
				return

			youtube.getInfo id, (params) =>
				if not params
					alert 'URLが不正です。'
					return

				youtube.change params.id

		# mount ---------------------------------------------
		@on 'mount', ->
			@width  = parseInt opts.width
			@height = parseInt opts.height
			@update()

		# resize --------------------------------------------
		observer.on 'resize', (params) =>
			console.log params
			@width  = parseInt params.width
			@height = parseInt params.height
			@update()
