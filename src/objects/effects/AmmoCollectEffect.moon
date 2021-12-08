export class AmmoCollectEffect extends GameObject
  new: (area, x, y, opts) =>
    super area, x, y, opts
    @depth = 100
    
    @w = @w * 1.5
    @h = @w
    @color = opts.color or Colors.white
    
    @timer\after 0.1, -> 
      @timer\after 0.15, -> @dead = true
 
  update: (dt) =>
    super dt

  draw: =>
    r,g,b,a = Graphics.getColor!
    Graphics.setColor @color
    Draft\rhombus @x, @y, @w, @h, 'fill'
    Graphics.setColor r,g,b,a
    

  destroy: =>
    super self
