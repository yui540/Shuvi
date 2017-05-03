top.load     = false
top.youtube  = require './youtube'
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

	youtube.resize width, height

# player ready ------------------------------------------------
top.onPlayerReady = (e) ->
	

# API ready ----------------------------------------------------
top.onYouTubeIframeAPIReady = ->
	top.load = true

