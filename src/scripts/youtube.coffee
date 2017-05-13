class YouTube
	constructor: ->
		YouTube = require 'youtube-node'
		@api    = new YouTube()
		@timer  = null
		@load   = false
		@player = null

		@api.setKey 'AIzaSyDNhc0Aof6i6Z49eps1aO6GpfSnuOvvT7M'

	##
	# iframe設置
	# @param id : 動画ID
	##
	set: (id) ->
		width  = window.innerWidth
		height = window.innerHeight

		@getInfo id, (params) =>
			if params is false
				alert '動画IDが不正です。'
				return

			@player = new YT.Player 'player', {
				width   : width
				height  : height
				videoId : id
				events  : {
					onReady: (e) =>
						@load = true
						youtube.play()
						observer.trigger 'play'
						observer.trigger 'load'
				}
			}
			@change id

	##
	# 動画の確認
	# @param id : 動画ID
	# @param fn : コールバック関数
	##
	getInfo: (id, fn) ->
		youtube.pause()
		observer.trigger 'pause'

		@api.search id, 1, (err, result) =>
			items = result.items

			if not items.length
				fn false

			enty   = items[0].snippet
			params = 
				id    : id
				title : enty.title
				thumb : enty.thumbnails.default.url

			observer.trigger 'preload', params
			fn params

	##
	# 動画の変更
	# @param id : 動画ID
	##
	change: (id) ->
		@load      = false
		url1       = 'https://www.youtube.com/embed/'
		url2       = '?enablejsapi=1&widgetid=1&controls=0&loop=1&showinfo=0'
		iframe     = document.getElementById 'player'
		iframe.src = url1 + id + url2

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
		match = url.match /v=.*/
		if not match
			return false

		match = match[0].split '&'
		id    = match[0].replace /^v=/, ''

		return id

	##
	# 再生
	##
	play: ->
		if not @load
			return

		@player.playVideo()
		observer.trigger 'play'

		@timer = setInterval =>
			duration = @duration()
			current  = @current()
			if duration <= current
				@seek 0

			observer.trigger 'seek'
		, 100

	##
	# 停止
	##
	pause: ->
		if not @load
			return
		
		@player.pauseVideo()
		observer.trigger 'pause'

		clearInterval @timer

	##
	# 移動
	# @param per : 0~1
	##
	seek: (per) ->
		duration = @duration()
		current  = duration * per

		@player.seekTo current

	##
	# 動画時間
	# @return duration
	##
	duration: ->
		return @player.getDuration()

	##
	# 現在時間
	# @return current
	##
	current: ->
		return @player.getCurrentTime()

	##
	# 読み込み状況
	# @return buffer
	##
	buffer: ->
		return @player.getVideoLoadedFraction()

	##
	# 音量の取得
	# @return volume
	##
	getVolume: ->
		return @player.getVolume()

	##
	# 音量の設定
	# @param volume : 0~100
	##
	setVolume: (volume) ->
		@player.setVolume volume
	
module.exports = new YouTube()