import insert from table
import remove from table

Utils = {}
Utils.room = {}

with Utils
  .resize = (s) ->
    Window.setMode s*G_baseW, s*G_baseH
    export G_sx, G_sy = s, s

  .recEnumerate = (folder, fileList)->
    items = Filesystem.getDirectoryItems folder
    for i, item in ipairs items
      if item\find('.moon', 1, true) ~= nil
        remove items, i
    for _, item in ipairs items
      file = folder .. "/" .. item
      if Filesystem.getInfo(file).type == "file"
        insert fileList, file
      elseif Filesystem.getInfo(file).type == "directory"
        Utils.recEnumerate file, fileList

  .requireFiles = (files) ->
    for _,file in ipairs files
      -- remove .lua
      file = file\sub 1, -5
      assert require file

  .room.gotoRoom = (roomType, ...) ->
    export G_currentRoom = _G[roomType](...)

  .pushRotate = (x, y, r) ->
    with Graphics
      .push!
      .translate x, y
      .rotate r or 0
      .translate -x, -y

  .pushRotateScale = (x, y, r, sx, sy) ->
    with Graphics
      .push!
      .translate x, y
      .rotate r or 0
      .scale sx or 1, sy or sx or 1
      .translate -x, -y  


  .slowDt = (amount = 1, dur = 0) ->
    love.slow = amount
    Gtimer\tween 'slow', dur, love, {slow: 1}, 'in-out-cubic'

    
    




Utils
