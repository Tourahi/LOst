random = love.math.random

class Ship

  @Fighter: ->
    return {
      name: 'Fighter'
      baseV: 100
      a: 100
      rv: 1.66*math.pi
      polys: {
        
      }
      idleColor: Colors.aqua
      burnColor: Colors.aqua
      boostColor: Colors.crimson
      slowColor: Colors.lightsteelblue
      boost: 1.5
      slow: 0.5
      burn: (player) ->
        player.area\addGameObject 'TailBurn',
          player.x - 0.9*player.w*math.cos(player.r) + 0.2*player.w*math.cos(player.r - math.pi/2),
          player.y - 0.9*player.w*math.sin(player.r) + 0.2*player.w*math.sin(player.r - math.pi/2),
          {parent: self, r: random(2, 4), d: Random(0.15, 0.25), color: player.ship.burnColor}

    }
    
