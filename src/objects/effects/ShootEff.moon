
export class ShootEff extends GameObject
  new: (area, x, y, opts) =>
    super area, x, y, opts
    @w = 8
    @x, @y = x, y
    @timer\tween 0.1, self, {w: 0}, 'in-out-cubic',-> @dead = true
 
  update: (dt) =>
    super dt
    if @player
      @x, @y = @player.x + @d*math.cos(@player.r),@player.y + @d*math.sin(@player.r)

  draw: =>
    Utils.pushRotate @x, @y, @player.r + math.pi/4
    Graphics.setColor Colors.white
    Graphics.rectangle 'fill', @x - @w/2, @y - @w/2, @w, @w
    Graphics.pop!

  destroy: =>
    super self