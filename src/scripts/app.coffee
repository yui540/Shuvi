top.player   = null
top.riot     = require 'riot'
top.observer = riot.observable()

require './component/js/application'

# load ---------------------------------------------------------
window.addEventListener 'load', ->
	width  = window.innerWidth
	height = window.innerHeight

	riot.mount 'application', 
		width  : width
		height : height

# resize -------------------------------------------------------
window.addEventListener 'resize', ->
	width  = window.innerWidth
	height = window.innerHeight

	observer.trigger 'resize', 
		width  : width
		height : height

	player.setSize width, height

# player ready ------------------------------------------------
top.onPlayerReady = (e) ->
	

# API ready ----------------------------------------------------
top.onYouTubeIframeAPIReady = ->
	width  = window.innerWidth
	height = window.innerHeight

	top.player = new YT.Player 'player', {
		width   : width
		height  : height
		videoId : 'HQlfjRO3JbY'
		events  : { onReady: onPlayerReady }
	}

