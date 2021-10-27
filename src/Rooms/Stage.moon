MManager = MeowC.core.Manager

export class Stage
  new: =>
    -- Area
    @area = Area self, assert(require('src/Rooms/GUI/Stage'))
    @area\addPhysicsWorld!
    @player = @area\addGameObject 'Player', G_baseW/2, G_baseH/2
    @mainCanvas = Graphics.newCanvas G_baseW, G_baseH
    @camera = Camera!

    Log.debug @player.id

  
  update: (dt) =>
    MManager\update dt
    @camera.smoother = Camera.smooth.damped 5
    @camera\lockPosition dt, G_baseW/2, G_baseH/2
    @camera\update dt
    @area\update dt

    if input\down 'f4'
      @player\die!
    if input\down 'f2'
      Leak.report!
    

  draw: () =>
    Graphics.setCanvas @mainCanvas
    Graphics.clear!

    @camera\attach 0, 0, G_baseW, G_baseH, 50
    @area\draw!
    MManager\draw!
    @camera\detach!

    Graphics.setCanvas!

    Graphics.setColor 1, 1, 1, 1
    Graphics.setBlendMode 'alpha', 'premultiplied'
    Graphics.draw @mainCanvas, 0, 0, 0, G_sx, G_sy
    Graphics.setBlendMode 'alpha'


  destroy: =>
    @area\destroy!
    @area = nil
