BebopSchema = {}

with BebopSchema
  .B1a = (B, ship, x, y) ->
    B.x = x - (ship.w * 2)
    B.y = y - ship.h
    B.w = 6
    B.h = 6
    B.polygons = {
      {      
        B.w, 0
        0, -B.h/2
        B.w/2, 0
        0, B.h/2
      }        
    }
    B.r = -math.pi / 2
    B.v = 0
    B.maxV = 100
    B.a = ship.a

    B.follow = (dt, p) =>
      @r = p.r
      @x, @y = p.x - (p.w*2), p.y - p.h
      @v = math.min @v + @a*dt, @maxV
      @collider\setLinearVelocity @v*math.cos(@r), @v*math.sin(@r)

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


BebopSchema