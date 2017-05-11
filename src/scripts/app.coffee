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
	width  = window.innerWidth
	height = window.innerHeight

	riot.mount 'application', 
		width  : width
		height : height

	init()
	youtube.set localStorage['id']

# resize -------------------------------------------------------
window.addEventListener 'resize', ->
	width  = window.innerWidth
	height = window.innerHeight

	observer.trigger 'resize', 
		width  : width
		height : height

	youtube.resize width, height

##
# 初期化
##
top.init = ->
	if not localStorage['id']
		localStorage['id'] = 'MGt25mv4-2Q'

