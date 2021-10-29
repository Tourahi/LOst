random = love.math.random

BebopFactory = {}

with BebopFactory
  .B1a = (B, ship, x, y) ->
    B.x = x - ship.w - 4
    B.y = y
    B.w = 8
    B.h = 8
    B.polygons = {
      {      
        B.w, 0
        0, -B.h/2
        B.w/2, 0
        0, B.h/2
      }        
    }
    B.r = 2.10*math.pi
    B.v = 0
    B.maxV = 150
    B.a = ship.a


    B.follow = (dt, p) =>
    
      if @x < 0 then @die!
      if @y < 0 then @die!
      if @x > G_baseW then @die!
      if @y > G_baseH then @die!

      @r = p.r
      if input\down 's'
        @collider\setLinearVelocity @maxV*math.cos(@r), @maxV*math.sin(@r)
      else
        @collider\setLinearVelocity p.v*math.cos(p.r), p.v*math.sin(p.r)


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

    B.die = =>
      @dead = true
      @area\getRoom!.player.bebop = nil
      with @area\getCamera!
        \shake 4, 40, 0.4
      for i = 1, love.math.random(10, 22) do @area\addGameObject 'PlayerExplode', @x, @y
 


BebopFactory