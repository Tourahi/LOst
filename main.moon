assert require 'src/globals'
freqCounter = assert require 'src/freqCounter'

love.clamp = (min, val, max) ->
  math.max(min, math.min(val, max))
  
if not love.frametime
  love.frametime =  1 / 60
if not love.ticksPerSecond
  love.ticksPerSecond = freqCounter!
if not love.framesPerSecond
  love.framesPerSecond =  freqCounter!
if not love.interPolateRender 
  love.interPolateRender = false 

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

    Utils.resize 3

  .update = (dt) ->
    timer\update dt
    if G_currentRoom
      G_currentRoom\update dt

  .draw = (interp) ->
    if G_currentRoom
      G_currentRoom\draw interp

  .run = ->
    if love.load
      love.load(love.arg.parseGameArguments(arg), arg)

    -- We don't want the first frame's dt to include time taken by love.load.
    if love.timer
      love.timer.step!

    dt = 0
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

      -- fuzzy timing snapping
      for _, v in ipairs {1/2, 1, 2}
        v = love.frametime * v
        if math.abs(dt - v) < 0.002
          dt = v

      -- dt clamping
      dt = love.clamp dt, 0, 2 * love.frametime
      acc += dt
      -- acc clamping
      acc = love.clamp acc, 0, 8 * love.frametime

      ticked = false

      -- run updates if ready
      while acc > love.frametime
        acc -= love.frametime
        love.update love.frametime
        love.ticksPerSecond\add!
        ticked = true


      if love.graphics and love.graphics.isActive! and (ticked or love.interPolateRender)
        love.graphics.origin!
        love.graphics.clear love.graphics.getBackgroundColor!

        if love.draw
          love.draw(acc / love.frametime)

        love.graphics.present!
        love.framesPerSecond\add!
      
      -- manual_gc(1e-3, 64, false)

      if love.timer
        love.timer.sleep 0.001

