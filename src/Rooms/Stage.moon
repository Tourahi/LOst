
export class Stage
  new: =>
    print "Stage"
    @area = Area!
    @area\addPhysicsWorld!
    @mainCanvas = Graphics.newCanvas G_baseW, G_baseH
    @camera = Camera!
    input\bind 'f3',-> @camera\shake 4, 100, 10
    @player = @area\addGameObject 'Player', G_baseW/2, G_baseH/2
    input\bind 'f4',-> @player.dead = true

  update: (dt) =>
    @camera.smoother = Camera.smooth.damped 5
    @camera\lockPosition dt, G_baseW/2, G_baseH/2
    @camera\update dt
    @area\update dt

  draw: =>
    Graphics.setCanvas @mainCanvas
    Graphics.clear!

    @camera\attach 0, 0, G_baseW, G_baseH, 50
    Graphics.circle 'line', G_baseW/2, G_baseH/2, 50
    @area\draw!
    @camera\detach!

    Graphics.setCanvas!

    Graphics.setColor 1, 1, 1, 1
    Graphics.setBlendMode 'alpha', 'premultiplied'
    Graphics.draw @mainCanvas, 0, 0, 0, G_sx, G_sy
    Graphics.setBlendMode 'alpha'
