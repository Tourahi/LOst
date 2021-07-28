import insert from table
import remove from table

Utils = {}
Utils.room = {}

with Utils
  .resize = (s) ->
    Window.setMode s*baseW, s*baseH
    baseW = s*baseW
    baseH = s*baseH
    export sx, sy = s, s

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
    G_currentRoom = _G[roomType](...)




Utils
