
export class Player extends GameObject
  new: (area, x, y, opts = {}) =>
    super area, x, y, opts
    @x, @y = x, y
    @w, @h = 12, 12
    @collider = area.world\newCircleCollider @x, @y, @w
    @collider\setObject self
  update: (dt) =>
    super self, dt

  draw: =>
    Graphics.circle 'line', @x, @y, @w
