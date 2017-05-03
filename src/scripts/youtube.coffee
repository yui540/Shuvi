class YouTube
	constructor: ->
		@load   = false
		@player = null

	##
	# iframe設置
	# @param id : 動画ID
	##
	set: (id) ->
		width  = window.innerWidth
		height = window.innerHeight

		@player = new YT.Player 'player', {
			width   : width
			height  : height
			videoId : id
			events  : { 
				onReady: (e) =>
					@load = true
			}
		}

	##
	# 動画の変更
	# @param id : 動画ID
	##
	change: (id) ->
		iframe     = document.getElementById 'player'
		iframe.src = 'https://www.youtube.com/embed/' + id + '?enablejsapi=1&widgetid=1&controls=0&loop=1&showinfo=0'

	##
	# 画面サイズ変更
	# @param width  : 幅
	# @param height : 高さ
	##
	resize: (width, height) ->
		@player.setSize width, height

	##
	# 動画IDの取得
	# @param url : URL
	# @return id
	##
	getId: (url) ->
		match = url.match(/v=.*/)
		if not match
			return false

		match = match[0].split('&')
		id    = match[0].replace /^v=/, ''

		return id
	
module.exports = new YouTube()