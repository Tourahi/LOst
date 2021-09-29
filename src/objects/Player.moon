
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

  update: (dt) =>
    super self, dt

    if input\down 'left'
      @r = @r - @rv*dt
    if input\down 'right'
      @r = @r + @rv*dt

    @v = math.min @v + @a*dt, @maxV
    @collider\setLinearVelocity @v*math.cos(@r), @v*math.sin(@r)

  draw: =>
    Graphics.circle 'line', @x, @y, @w
    Graphics.line @x, @y, @x + 2*@w*math.cos(@r), @y + 2*@w*math.sin(@r)

  destroy: =>
    super\destroy self