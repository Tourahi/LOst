export class BoostCollectEffect extends GameObject
  new: (area, x, y, opts) =>
    super area, x, y, opts
    @depth = 100

    @x, @y = math.floor(@x), math.floor(@y)
    @visible = true
    @sx, @sy = 1, 1
    @color = opts.color or Colors.white

    @timer\after 0.2, ->
        @timer\after 0.35, ->
            @dead = true

    @timer\after 0.2, ->
        @timer\every 0.05, -> @visible = not @visible, 6
        @timer\after 0.35, -> @visible = true
    
    @timer\tween 0.35, self, {sx: 2, sy:2}, 'in-out-cubic'


 
  update: (dt) =>
    super dt

  draw: =>
    if not @visible then return

    r,g,b,a = Graphics.getColor!
    Graphics.setColor @color
    Draft\rhombus @x, @y, math.floor(1.34*@w), math.floor(1.34*@h), 'fill'
    Draft\rhombus @x, @y, @sx*2*@w, @sy*2*@h, 'line'
    Graphics.setColor r,g,b,a
    

  destroy: =>
    super self

