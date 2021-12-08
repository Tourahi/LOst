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

    if @collider\enter 'Player'
      object = @collider\getEnterCollisionData('Player').collider\getObject!
      object.boost = 100
      @die!
      
    if @area.room.player
      projectileHeading = Vector2D(@collider\getLinearVelocity!)\norm!
      angle = math.atan2 @area.room.player.y - @y, @area.room.player.x - @x
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
    
  die: =>
    @dead = true
    for i = 1, love.math.random(4, 6) do @area\addGameObject 'PlayerExplode', @x, @y, {color: @color}
    @area\addGameObject 'ResourceCollectEffect', @x, @y, {
      color: @color, w: @w, h: @h}
      
  destroy: =>
      super self
