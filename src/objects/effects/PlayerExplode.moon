random = love.math.random

export class PlayerExplode extends GameObject
  new: (area, x, y, opts) =>
    super area, x, y, opts
    @color = opts.color or Colors.yellow
    @r = random 0, 2.5*math.pi
    @s = opts.s or random 2, 3
    @v = opts.v or random 75, 150
    @lineW = 2
    @timer\tween(opts.d or random(0.3, 0.5), self, {s:0, v:0, lineW:0},'linear', -> @dead = true)

  update: (dt) =>
    super dt
    @x += @v*math.cos(@r)*dt
    @y += @v*math.sin(@r)*dt

  draw: =>
    Utils.pushRotate @x, @y, @r
    with Graphics
      .setLineWidth @lineW
      .setColor @color
      .line @x - @s, @y, @x + @s, @y
      .setColor Colors.white
      .setLineWidth 1
      .pop!

  destroy: =>
    super\destroy self
