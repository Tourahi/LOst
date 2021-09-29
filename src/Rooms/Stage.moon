
export class Stage
  new: =>
    @area = Area!
    @area\addPhysicsWorld!
    @mainCanvas = Graphics.newCanvas G_baseW, G_baseH
    @camera = Camera!
    input\bind 'f3',-> @camera\shake 10, 100, 10
    @player = @area\addGameObject 'Player', G_baseW/2, G_baseH/2
    input\bind 'f4', 'f4'

    -- INput debug
    input\bind 'd',"print"

    Log.debug @player.id
    
  update: (dt) =>
    @camera.smoother = Camera.smooth.damped 5
    @camera\lockPosition dt, G_baseW/2, G_baseH/2
    @camera\update dt
    @area\update dt

    if input\down 'f4'
      @player.dead = true
      
    if input\sequence('right', 0.5, 'left', 0.5, 'print')
      print "hello"

  draw: () =>
    Graphics.setCanvas @mainCanvas
    Graphics.clear!

    @camera\attach 0, 0, G_baseW, G_baseH, 50
    @area\draw!
    @camera\detach!

    Graphics.setCanvas!

    Graphics.setColor 1, 1, 1, 1
    Graphics.setBlendMode 'alpha', 'premultiplied'
    Graphics.draw @mainCanvas, 0, 0, 0, G_sx, G_sy
    Graphics.setBlendMode 'alpha'

  destroy: =>
    @area\destroy!
    @area = nil
