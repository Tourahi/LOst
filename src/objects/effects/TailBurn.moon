random = love.math.random

export class TailBurn extends GameObject
  new: (area, x, y, opts) =>
    super area, x, y, opts
    @depth = 100

    @r = opts.r or random 4, 6
    @timer\tween opts.d or random(0.3, 0.5), self, {r: 0}, 'linear', -> @dead = true

  update: (dt) =>
    super dt

  draw: =>
    Graphics.setColor @color
    Graphics.circle 'fill', @x, @y, @r
    Graphics.setColor Colors.white

  destroy: =>
    super self
