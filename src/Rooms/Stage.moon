
export class Stage
  new: =>
    @area = Area!
    @area\addPhysicsWorld!
    @mainCanvas = Graphics.newCanvas baseW, baseH
    @camera = Camera!
    input\bind 'f3',-> @camera\shake 4, 60, 1
    @player = @area\addGameObject 'Player', baseW/2, baseH/2
    input\bind 'f4',-> @player.dead = true

  update: (dt) =>
    @camera.smoother = Camera.smooth.damped 5
    @camera\lockPosition dt, baseW/2, baseH/2
    @camera\update dt
    @area\update dt

  draw: =>
    Graphics.setCanvas @mainCanvas
    Graphics.clear!

    @camera\attach 0, 0, baseW, baseH, 50
    -- Graphics.circle 'line', baseW/2, baseH/2, 50
    @area\draw!
    @camera\detach!

    Graphics.setCanvas!

    Graphics.setColor 1, 1, 1, 1
    Graphics.setBlendMode 'alpha', 'premultiplied'
    Graphics.draw @mainCanvas, 0, 0, 0, sx, sy
    Graphics.setBlendMode 'alpha'
