random = love.math.random
Ship = assert require 'src/objects/Ship'

export class Player extends GameObject
  new: (area, x, y, opts = {}) =>
    super area, x, y, opts
    @ship = Ship.Needle!
    @polygons = @ship\polys!

    @x, @y = x, y
    @w, @h = @ship.w, @ship.h
    @collider = area.world\newCircleCollider @x, @y, @w
    @collider\setObject self

    -- Movement related properties
    @r = -math.pi / 2
    @rv = @ship.rv
    @v = 0
    @maxV = @ship.baseV
    @a = @ship.a
    @boosting = 0

    @area.GUI.bBar\setColor @ship.boostColor


    -- Timers
    @timer\every 0.24, -> @shoot!
    if opts.glitchEnabled
      @timer\every 5, -> @glitch!

    @tailBurn!

  update: (dt) =>
    super dt
    @boosting = 0
    @maxV = @ship.baseV

    if not @area.GUI.bBar\isEmpty!
      if input\down 'up'
        @boosting = 1
        @area.GUI.bBar\setValue @area.GUI.bBar.value - 0.5
        @maxV = @ship.boost*@ship.baseV
        
    if input\down 'down' 
      @boosting = -1
      @maxV = @ship.slow*@ship.baseV


    if input\down 'left'
      @r = @r - @rv*dt
    if input\down 'right'
      @r = @r + @rv*dt

    @v = math.min @v + @a*dt, @maxV
    @collider\setLinearVelocity @v*math.cos(@r), @v*math.sin(@r)

    switch @boosting
      when 1
        @ship.burnColor = @ship.boostColor
      when -1
        @ship.burnColor = @ship.slowColor
      when 0
        @ship.burnColor = @ship.idleColor




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

    --Graphics.circle 'line', @x, @y, @w
    --Graphics.line @x, @y, @x + @w*math.cos(@r), @y + @w*math.sin(@r)

 
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

  tailBurn: =>
    @timer\every 0.01, ->
      @ship.burn self

  destroy: =>
    super self