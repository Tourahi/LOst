export class Projectile extends GameObject
  new: (area, x, y, opts) =>
    super area, x, y, opts
    __name = 'lol'
    @s = opts.s or 2.5
    @v = opts.v or 200
    @color = Colors.white
    
    @collider = @area.world\newCircleCollider @x, @y, @s
    with @collider
      \setObject self
      \setLinearVelocity @v*math.cos(@r), @v*math.sin(@r)
      \setPreSolve (c1, c2, contact)->
        if c2.id == @area.room.player.bebop.id
          contact\setEnabled false

  update: (dt) =>
    super dt
    @collider\setLinearVelocity @v*math.cos(@r), @v*math.sin(@r)
    if @x < 0 then @die!
    if @y < 0 then @die!
    if @x > G_baseW then @die!
    if @y > G_baseH then @die!

  draw: =>
    Graphics.setColor Colors.white
    Graphics.circle 'line', @x, @y, @s

  die: =>
    @dead = true
    @area\addGameObject 'ProjectileDE', @x, @y, {color: @color or Colors.white, w: 3*@s}

  destroy: =>
    super\destroy self
