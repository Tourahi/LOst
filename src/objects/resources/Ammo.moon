

export class Ammo extends GameObject
  new: (area, x, y, opts) =>
    super area, x, y, opts
    @w, @h = 8, 8
    @collider = @area.world\newRectangleCollider @x, @y, @w, @h
    @r = Random 0.2 * math.pi
    @v = Random 10, 20
    @color = opts.color
    with @collider
      \setObject self
      \setCollisionClass 'Collectable'
      \setFixedRotation false
      \setLinearVelocity @v*math.cos(@r), @v*math.sin(@r)
      \applyAngularImpulse Random(-24, 24)
    
  update: (dt) =>
    super dt
    target = @area.room.player
    if target
      projectileHeading = Vector2D(@collider\getLinearVelocity!)\norm!
      angle = math.atan2 target.y - @y, target.x - @x
      toTargetHeading = Vector2D(math.cos(angle), math.sin(angle))\norm!
      finalHeading = (projectileHeading + 0.1*toTargetHeading)\norm!
      @collider\setLinearVelocity @v * finalHeading.x, @v * finalHeading.y
    else
      @collider\setLinearVelocity @v*math.cos(@r), @v*math.sin(@r)
    
  draw: =>
    r, g, b, a = Graphics.getColor!
    Graphics.setColor @color
    Utils.pushRotate @x, @y, @collider\getAngle!
    Draft\rhombus @x, @y, @w, @h, 'line'
    Graphics.pop!
    Graphics.setColor r, g, b, a
    
    
