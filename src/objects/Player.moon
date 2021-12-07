random = love.math.random
Ships = assert require 'src/objects/Ships'

export class Player extends GameObject
  new: (area, x, y, opts = {}) =>
    super area, x, y, opts
    @ship = Ships.Needle!
    @polygons = @ship\polys!

    @bebop = area\addGameObject 'Bebop', @x, @y, {ship: @ship, type: 'B1a'}

    @x, @y = x, y
    @w, @h = @ship.w, @ship.h
    @collider = area.world\newCircleCollider @x, @y, @w
    with @collider
      \setObject self
      \setCollisionClass 'Player'

    -- Movement related properties
    @r = -math.pi / 2
    @rv = @ship.rv
    @v = 0
    @maxV = @ship.baseV
    @a = @ship.a
    @boosting = 0
    @maxBoost = 100
    @boost = @maxBoost
    @canBoost = true
    @boostTimer = 0
    @boostCooldown = 2
    
    @maxHp = 100
    @hp = @maxHp
    
    @maxAmmo = 100
    @ammo = @maxAmmo

    @area.GUI.bBar\setColor @ship.boostColor


    -- Timers
    @timer\every 0.24, -> 
      @ship\shoot self
      if @bebop
        @bebop\shoot!
        
    if opts.glitchEnabled
      @timer\every 5, -> @glitch!

    @tailBurn!

  update: (dt) =>
    super dt
    
    if @x < 0 then @die!
    if @y < 0 then @die!
    if @x > G_baseW then @die!
    if @y > G_baseH then @die!
    
    if @boostTimer > @boostCooldown then @canBoost = true
    @boost = math.min @boost + 10*dt, @maxBoost  
    @boostTimer += dt
    @boosting = 0
    @maxV = @ship.baseV
    
   -- if @collider\enter 'Collectable'
       -- Log.debug 'ENter'

    if input\down('up') and @boost > 1 and @canBoost
      @boosting = 1
      color = @area.GUI.bBar.color
      @boost = @boost - 50*dt
      if @boost <= 1
       @boosting = 0
       @canBoost = false
       @boostTimer = 0
      @maxV = @ship.boost*@ship.baseV
        
    if input\down('down') and @boost > 1 and @canBoost
      @boosting = -1
      @maxV = @ship.slow*@ship.baseV
      @boost = @boost - 50*dt
      if @boost <= 1
        @boosting = 0
        @canBoost = false
        @boostTimer = 0
      
      
    @area.GUI.bBar\setValue @boost


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
    
    if @bebop
      @bebop\follow dt, self

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
