assert require 'src/globals'
import insert from table
import remove from table

export currentRoom = nil

with love
  .load = ->
    Graphics.setDefaultFilter 'nearest', 'nearest'
    Graphics.setLineStyle 'rough'
    objectFiles = {}
    recEnumerate 'src/objects', objectFiles
    requireFiles objectFiles
    roomFiles = {}
    recEnumerate 'src/Rooms', roomFiles
    requireFiles roomFiles

    export timer = Timer!
    export input = Input!

    gotoRoom 'Stage'

    resize 2

  .update = (dt) ->
    timer\update dt
    if currentRoom
      currentRoom\update dt

  .draw = ->
    if currentRoom
      currentRoom\draw!

  .run = ->
    if love.load
      love.load(love.arg.parseGameArguments(arg), arg)

    -- We don't want the first frame's dt to include time taken by love.load.
    if love.timer
      love.timer.step()

    dt = 0
    fixedDt = 1/60
    acc = 0
    -- Main loop time.
    return () ->
      -- Process events.
      if love.event
        love.event.pump()
        for name, a,b,c,d,e,f in love.event.poll()
          if name == "quit"
            if not love.quit or not love.quit()
              return a or 0
          love.handlers[name](a,b,c,d,e,f)

      -- Update dt, as we'll be passing it to update
      if love.timer
        dt = love.timer.step()
      -- Call update and draw
      acc += dt
      while acc >= fixedDt
        if love.update
          love.update(fixedDt)  -- will pass 0 if love.timer is disabled
        acc -= fixedDt

      if love.graphics and love.graphics.isActive()
        love.graphics.origin()
        love.graphics.clear(love.graphics.getBackgroundColor())

        if love.draw
          love.draw()

        love.graphics.present()

      if love.timer
        love.timer.sleep(0.001)



export resize = (s) ->
  Window.setMode s*baseW, s*baseH
  baseW = s*baseW
  baseH = s*baseH
  export sx, sy = s, s

export recEnumerate = (folder, fileList)->
  items = Filesystem.getDirectoryItems folder
  for i, item in ipairs items
    if item\find('.moon', 1, true) ~= nil
      remove items, i
  for _, item in ipairs items
    file = folder .. "/" .. item
    if Filesystem.getInfo(file).type == "file"
      insert fileList, file
    elseif Filesystem.getInfo(file).type == "directory"
      recEnumerate file, fileList

export requireFiles = (files) ->
  for _,file in ipairs files
    -- remove .lua
    file = file\sub 1, -5
    assert require file

export gotoRoom = (roomType, ...) ->
  currentRoom = _G[roomType](...)

