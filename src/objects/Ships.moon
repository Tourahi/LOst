random = love.math.random

Ships = {}

with Ships
  .Needle = ->
    return {
      name: 'Needle'
      baseV: 100
      a: 100
      fromP: 60
      rv: 2.10*math.pi
      w: 12
      h: 12
      polys: =>
        {
          { -- Center Poly
            @w, 0
            -@w/2, -@h/3
            -@w, 0
            -@w/2, @h/3
          }
        }
      idleColor: Colors.aqua
      burnColor: Colors.aqua
      boostColor: Tint\lighten 0.099, Colors.magenta
      slowColor: Colors.white
      boost: 1.5
      slow: 0.5

      burn: (player) ->
        player.area\addGameObject 'TailBurn',
          player.x - player.w*math.cos(player.r) + 0.2*player.w*math.cos(player.r - math.pi/0.98),
          player.y - 0.9*player.w*math.sin(player.r) + 0.2*player.w*math.sin(player.r - math.pi/0.98),
          {parent: self, r: random(2, 4), d: Random(0.15, 0.25), color: player.ship.burnColor}

      shoot: (p) =>
        d = 1.2*@w
        p.area\addGameObject 'ShootEff', p.x + 1.2*@w*math.cos(p.r),
          p.y + 1.2*@w*math.sin(p.r), {player: p, d: d}
        p.area\addGameObject 'Projectile', p.x + 1.5*@w*math.cos(p.r),
          p.y + 1.5*@w*math.sin(p.r), {r: p.r}
    
    }
    
Ships