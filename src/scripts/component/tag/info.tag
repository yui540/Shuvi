info
	div.title(title="{ title }") { title }
	div.art
		div.line.line1: div
		div.line.line2: div
		div.line.line3: div
		div.line.line4: div
		div.line.line5: div
		div.line.line6: div
		div.line.line7: div
		div.line.line8: div
		div.line.line9: div
		div.line.line10: div
		div.line.line11: div
		div.line.line12: div
		div.line.line13: div
		div.line.line14: div
		div.line.line15: div
		div.line.line16: div
		div.line.line17: div
		div.line.line18: div
		div.line.line19: div

	style(scoped).
		:scope {
			display: block;
			float: left;
			width: 190px;
			height: 40px;
			margin-left: 10px;
		}
		:scope .title {
			width: 190px;
			height: 20px;
			font-size: 10px;
			color: #ccc;
			line-height: 20px;
			background-color: #444;
			box-sizing: border-box;
			padding: 0 5px;
			border-radius: 2px;
			overflow: hidden;
		}
		:scope .art {
			width: 190px;
			height: 20px;
		}
		:scope .art:after {
			content: "";
			display: block;
			clear: both;
		}
		:scope .art .line {
			position: relative;
			float: left;
			width: 5px;
			height: 20px;
			margin-right: 5px;
		}
		:scope .art .line div {
			position: absolute;
			left: 0;
			bottom: 0;
			width: 5px;
			height: 2px;
			background-color: #E27171;
		}
		:scope .art[data-state="active"] .line1 div { animation: art 2s ease 0s infinite; }
		:scope .art[data-state="active"] .line2 div { animation: art 2s ease 0.3s infinite; }
		:scope .art[data-state="active"] .line3 div { animation: art 2s ease 0.6s infinite; }
		:scope .art[data-state="active"] .line4 div { animation: art 2s ease 0.9s infinite; }
		:scope .art[data-state="active"] .line5 div { animation: art 2s ease 1.2s infinite; }
		:scope .art[data-state="active"] .line6 div { animation: art 2s ease 1.5s infinite; }
		:scope .art[data-state="active"] .line7 div { animation: art 2s ease 1.8s infinite; }
		:scope .art[data-state="active"] .line8 div { animation: art 2s ease 2.1s infinite; }
		:scope .art[data-state="active"] .line9 div { animation: art 2s ease 2.4s infinite; }
		:scope .art[data-state="active"] .line10 div { animation: art 2s ease 2.8s infinite; }
		:scope .art[data-state="active"] .line11 div { animation: art 2s ease 3.1s infinite; }
		:scope .art[data-state="active"] .line12 div { animation: art 2s ease 3.4s infinite; }
		:scope .art[data-state="active"] .line13 div { animation: art 2s ease 3.8s infinite; }
		:scope .art[data-state="active"] .line14 div { animation: art 2s ease 4.1s infinite; }
		:scope .art[data-state="active"] .line15 div { animation: art 2s ease 4.4s infinite; }
		:scope .art[data-state="active"] .line16 div { animation: art 2s ease 4.8s infinite; }
		:scope .art[data-state="active"] .line17 div { animation: art 2s ease 5.1s infinite; }
		:scope .art[data-state="active"] .line18 div { animation: art 2s ease 5.4s infinite; }
		:scope .art[data-state="active"] .line19 div { animation: art 2s ease 5.8s infinite; }
		@keyframes art {
			0%   { height: 2px; }
			50%  { height: 15px; }
			100% { height: 2px; }
		}

	script(type="coffee").

		# load ----------------------------------------------
		observer.on 'load', (params) =>
			@title = params.title
			@update()

		# play ----------------------------------------------
		observer.on 'play', =>
			@root.children[1].setAttribute 'data-state', 'active'

		# pause ----------------------------------------------
		observer.on 'pause', =>
			@root.children[1].setAttribute 'data-state', ''

		# mount ---------------------------------------------
		@on 'mount', ->
			@title = 'no_title'
			@update()
