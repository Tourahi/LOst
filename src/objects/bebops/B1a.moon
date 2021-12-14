B1a = (B, ship, x, y) ->
  B.x = x - ship.w - 9
  B.y = y + 7
  B.w = 8
  B.h = 8
  B.polygons = {
    {      
      B.w, 0
      0, -B.h/2
      -B.w/2, 0
      0, B.h/2
    }        
  }
  
  B.r = -math.pi / 2
  B.rv = ship.rv
  B.v = 0
  B.maxV = ship.baseV
  B.a = 100
  B.offsetFromPlayer = Vector2D 10, 10

  B.follow = assert require 'src/objects/bebops/ai/followPlayer1'

  B.draw = =>
    Utils.pushRotate @x, @y, @r
    for _, poly in ipairs @polygons
      points = fn.map(poly, (v, k) ->
        if k % 2 == 1
          return @x + v
        else
          return @y + v
      )
      Graphics.polygon 'line', points
    Graphics.pop!
    
  
  B.shoot = =>
    d = 1.2*@w
    @area\addGameObject 'ShootEff', @x + 1.2*@w*math.cos(@r),
      @y + 1.2*@w*math.sin(@r), {player: self, d: d, w: 4}
    @area\addGameObject 'Projectile', @x + 1.5*@w*math.cos(@r),
      @y + 1.5*@w*math.sin(@r), {r: @r, s: 1.2}

  B.die = =>
    @dead = true
    @area\getRoom!.player.bebop = nil
    with @area\getCamera!
      \shake 4, 40, 0.4
    for i = 1, love.math.random(10, 22) do @area\addGameObject 'PlayerExplode', @x, @y

  return B


B1a