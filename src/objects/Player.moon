
export class Player extends GameObject
  new: (area, x, y, opts = {}) =>
    super area, x, y, opts
    @x, @y = x, y
    @w, @h = 12, 12
    @collider = area.world\newCircleCollider @x, @y, @w
    @collider\setObject self

    -- Movement related properties
    @r = -math.pi / 2
    @rv = 1.66*math.pi
    @v = 0
    @maxV = 100
    @a = 100

    -- Timers
    @timer\every 0.24, -> @shoot!
    @timer\every 5, -> @glitch!

  update: (dt) =>
    super dt
    if input\down 'left'
      @r = @r - @rv*dt
    if input\down 'right'
      @r = @r + @rv*dt

    @v = math.min @v + @a*dt, @maxV
    @collider\setLinearVelocity @v*math.cos(@r), @v*math.sin(@r)

  draw: =>
    Graphics.circle 'line', @x, @y, @w
    Graphics.line @x, @y, @x + @w*math.cos(@r), @y + @w*math.sin(@r)

 
  shoot: =>
    d = 1.2*@w
    @area\addGameObject 'ShootEff', @x + 1.2*@w*math.cos(@r),
      @y + 1.2*@w*math.sin(@r), {player: self, d: d}
    @area\addGameObject 'Projectile', @x + 1.5*@w*math.cos(@r),
      @y + 1.5*@w*math.sin(@r), {r: @r}
    

  die: =>
    @dead = true
    if opts.flashEnabled
      Utils.screenFlash 3
    Utils.slowDt 0.2, 1
    with @area\getCamera!
      \shake 4, 40, 0.4
    for i = 1, love.math.random(8, 10) do @area\addGameObject 'PlayerExplode', @x, @y

 
  glitch: =>
    @area\addGameObject 'TickEff', @x, @y, {parent: self}

  destroy: =>
    super self