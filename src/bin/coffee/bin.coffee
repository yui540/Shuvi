fs       = require 'fs'
path     = require 'path'
express  = require 'express'
electron = require 'electron'
app      = electron.app
Browser  = electron.BrowserWindow
Menu     = electron.Menu
ipc      = electron.ipcMain
www      = express()

#config
html          = '../../views/html/player.html'
window_config = require '../../config/window.json'
template = [
  {
    label: 'Edit',
    submenu: [
      {role: 'undo'},
      {role: 'redo'},
      {type: 'separator'},
      {role: 'cut'},
      {role: 'copy'},
      {role: 'paste'},
      {role: 'pasteandmatchstyle'},
      {role: 'delete'},
      {role: 'selectall'}
    ]
  },
  {
    label: 'View',
    submenu: [
      {role: 'reload'},
      {role: 'forcereload'},
      {role: 'toggledevtools'},
      {type: 'separator'},
      {role: 'resetzoom'},
      {role: 'zoomin'},
      {role: 'zoomout'},
      {type: 'separator'},
      {role: 'togglefullscreen'}
    ]
  },
  {
    role: 'window',
    submenu: [
      {role: 'minimize'},
      {role: 'close'}
    ]
  }
]

# ready -----------------------------------------------------------
win = null
app.on 'ready', ->
	win = new Browser window_config
	win.loadURL 'file://' + path.join(__dirname, html)

	win.on 'closed', ->
		win = null

	menu = Menu.buildFromTemplate(template)
	Menu.setApplicationMenu(menu)

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
