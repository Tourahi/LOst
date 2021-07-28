assert require 'src/globals'

with love
  .load = ->
    Graphics.setDefaultFilter 'nearest', 'nearest'
    Graphics.setLineStyle 'rough'
    objectFiles = {}
    Utils.recEnumerate 'src/objects', objectFiles
    Utils.requireFiles objectFiles
    roomFiles = {}
    Utils.recEnumerate 'src/Rooms', roomFiles
    Utils.requireFiles roomFiles

    export timer = Timer!
    export input = Input!

    Utils.room.gotoRoom 'Stage'

    Utils.resize 2

  .update = (dt) ->
    timer\update dt
    if G_currentRoom
      G_currentRoom\update dt

  .draw = ->
    if G_currentRoom
      G_currentRoom\draw!

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

