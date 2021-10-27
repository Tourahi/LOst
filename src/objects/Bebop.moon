
export class Bebop extends GameObject
  new: (area, x, y, ship) =>
    super area, x, y
    @x, @y = x - (ship.w * 2), y - ship.h
    @w, @h = 6, 6
    @collider = area.world\newCircleCollider @x, @y, @w
    @collider\setObject self
    @collider\setPreSolve (c1, c2, contact)->
      contact\setEnabled false
    @polygons = {
      {      
        @w, 0
        0, -@h/2
        @w/2, 0
        0, @h/2
      }
    }

    @r = -math.pi / 2
    @v = 0
    @maxV = 100
    @a = ship.a
 


  follow: (dt, p) =>
    @r = p.r
    @x, @y = p.x - (p.w*2), p.y - p.h
    @v = math.min @v + @a*dt, @maxV

    @collider\setLinearVelocity @v*math.cos(@r), @v*math.sin(@r)



  draw: =>
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