top.ipc      = require('electron').ipcRenderer
top.youtube  = require './youtube'
top.riot     = require 'riot'
top.observer = riot.observable()

require './component/js/application'
require './component/js/title-bar'
require './component/js/controls'
require './component/js/seek'
require './component/js/play'
require './component/js/info'
require './component/js/volume'
require './component/js/overray'
require './component/js/history'

# load ---------------------------------------------------------
window.addEventListener 'load', ->
	init()
	width  = window.innerWidth
	height = window.innerHeight

	riot.mount '*', 
		width  : width
		height : height

	youtube.set localStorage['id']

# resize -------------------------------------------------------
window.addEventListener 'resize', ->
	width  = window.innerWidth
	height = window.innerHeight

	observer.trigger 'resize', 
		width  : width
		height : height

	youtube.resize width, height

# preload ------------------------------------------------------
observer.on 'preload', (params) ->
	history = JSON.parse localStorage['history']

	for val, i in history
		if not val
			continue
		if val.id is params.id
			history.splice i, 1

	history.unshift params

	if history.length > 100
		history.splice (history.length - 1), 1

	localStorage['id']      = params.id
	localStorage['history'] = JSON.stringify history

##
# 初期化
##
top.init = ->
	# 初期動画
	id    = 'fQN2WC_Acpg'
	title = 'https://i.ytimg.com/vi/fQN2WC_Acpg/default.jpg'
	thumb = '映画『ノーゲーム・ノーライフ ゼロ』 PV 第1弾'

	if not localStorage['id']
		localStorage['id']      = id
		localStorage['history'] = JSON.stringify([{ 
			id    : id
			title : title
			thumb : thumb 
		}])

