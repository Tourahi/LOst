export class ProjectileDE extends GameObject
  new: (area, x, y, opts) =>
    super area, x, y, opts
    @first = true
    @timer\after 0.1, ->
      @first = false
      @second = true
      @timer\after 0.15, ->
        @second = false
        @dead = true

  update: (dt) =>
    super dt

  draw: =>
    if @first then Graphics.setColor Colors.white
    elseif @second then Graphics.setColor Colors.mediumvioletred
    Graphics.rectangle 'fill', @x - @w/2, @y - @w/2, @w, @w

  destroy: =>
    super\destroy self
