fs       = require 'fs'
path     = require 'path'
express  = require 'express'
electron = require 'electron'
app      = electron.app
Browser  = electron.BrowserWindow
ipc      = electron.ipcMain
www      = express()

#config
window_config = require '../../config/window.json'

# ready -----------------------------------------------------------
win = null
app.on 'ready', ->
	win = new Browser window_config
	win.loadURL 'file://' + path.join(__dirname, '../../views/html/player.html')

	win.on 'closed', ->
		win = null

# window all closed -----------------------------------------------
app.on 'window-all-closed', ->
	app.quit()