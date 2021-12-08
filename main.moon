assert require 'src/globals'
Input = assert require 'src/libs/Input'

with love
  .load = ->
    export input = Input!
    Graphics.setDefaultFilter 'nearest', 'nearest'
    Graphics.setLineStyle 'rough'
    Graphics.setBackgroundColor Colors.customDim
    objectFiles = {}
    Utils.recEnumerate 'src/objects', objectFiles
    Utils.requireFiles objectFiles
    roomFiles = {}
    Utils.recEnumerate 'src/Rooms', roomFiles
    Utils.requireFiles roomFiles

    export timer = Timer!

    Utils.room.gotoRoom 'Stage'

    Utils.resize opts.gameScale

    input\bindArr {
      'right': 'right'
      'left': 'left'
      'up': 'up'
      'down': 'down'
      'f2': 'f2'
      'f4': 'f4'
      'l': 'l'
      's': 's'
      'return': 'enter'
      'escape': 'escape'
    }

  .update = (dt) ->
    if input\down 'escape' then love.event.quit!
    timer\update dt * love.slow
    if G_currentRoom
      G_currentRoom\update dt * love.slow

  .draw = ->
    if G_currentRoom then G_currentRoom\draw!
    Utils.drawFlash!

  .run = ->
    if love.load
      love.load(love.arg.parseGameArguments(arg), arg)

    -- We don't want the first frame's dt to include time taken by love.load.
    if love.timer
      love.timer.step!

    dt = 0
    fixedDt = 1/60
    acc = 0
    -- Main loop time.
    return () ->
      -- Process events.
      if love.event
        love.event.pump!
        for name, a,b,c,d,e,f in love.event.poll!
          if name == "quit"
            if not love.quit or not love.quit!
              return a or 0
          love.handlers[name] a,b,c,d,e,f

      -- Update dt, as we'll be passing it to update
      if love.timer
        dt = love.timer.step!
      -- Call update and draw
      acc += dt
      while acc >= fixedDt
        if love.update
          love.update fixedDt
        acc -= fixedDt

      if love.graphics and love.graphics.isActive!
        love.graphics.origin!
        love.graphics.clear love.graphics.getBackgroundColor!

        if love.draw
          love.draw!

        love.graphics.present!

      if love.timer
        love.timer.sleep 0.001

