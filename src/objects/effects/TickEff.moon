export class TickEff extends GameObject
  new: (area, x, y, opts) =>
    super area, x, y, opts
    @depth = 100
    @w, @h = 48, 32
    @yOffset = 0
    @timer\tween 0.13, self, {h: 0, yOffset: 32}, 'in-out-cubic', -> @dead = true

  update: (dt) =>
    super dt
    if @parent
      @x, @y = @parent.x, @parent.y - @yOffset

  draw: =>
    Graphics.setColor Colors.white
    Graphics.rectangle 'fill', @x - @w/2, @y, @w, @h
    Graphics.setColor Colors.white

  destroy: =>
    super self



