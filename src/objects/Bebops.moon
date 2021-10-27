

Bebops = {}

with Bebops
  .B1a = (s) ->
    return {
      x: s.x
      y: s.y
      v: 0
      r: s.r
      name: 'B1a'
      baseV: 85
      a: 90
      rv: 2*math.pi
      w: 6
      h: 6
      polys: =>
        {
          {
            @w, 0
            0, -@h/2
            @w/2, 0
            0, @h/2
          }
        }

      draw: =>
        

      follow: (ship) =>
        @x = ship.x

    }