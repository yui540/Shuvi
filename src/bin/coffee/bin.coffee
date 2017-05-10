fs       = require 'fs'
path     = require 'path'
express  = require 'express'
electron = require 'electron'
app      = electron.app
Browser  = electron.BrowserWindow
ipc      = electron.ipcMain
www      = express()

#config
html          = '../../views/html/player.html'
window_config = require '../../config/window.json'

# ready -----------------------------------------------------------
win = null
app.on 'ready', ->
	win = new Browser window_config
	win.loadURL 'file://' + path.join(__dirname, html)

	win.on 'closed', ->
		win = null

# window all closed -----------------------------------------------
app.on 'window-all-closed', ->
	app.quit()

# close -----------------------------------------------------------
ipc.on 'close', ->
	app.quit()

###################################################################
#
# API Server
#
###################################################################
server = www.listen 8080, ->
	console.log ''
	console.log '################################################################'
	console.log ''
	console.log ' starting WEB SERVER on localhost:' + server.address().port
	console.log '   AUTHOR:     yuki540'
	console.log '   REPOSITORY: https://github.com/yuki540net/yui'
	console.log ''
	console.log '################################################################'
	console.log ''
