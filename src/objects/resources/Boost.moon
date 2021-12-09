export class Boost extends GameObject
  new: (area, x, y, opts) =>
    super area, x, y, opts
    @dir = table.random {-1, 1}
    @x = G_baseW/2 + @dir*(G_baseW/2 + 48)
    @y = Random 48, G_baseH - 48
    @w, @h = 12, 12
    @collider = @area.world\newRectangleCollider @x, @y, @w, @h
    @color = opts.color
    @v = -@dir * Random(20, 40)
    with @collider
      \setObject self
      \setCollisionClass 'Collectable'
      \setFixedRotation false
      \setLinearVelocity @v, 0
      \applyAngularImpulse Random(-24, 24)
    
  update: (dt) =>
    super dt

    if @collider\enter 'Player'
      @area.room.player\addBoost 15
      @die!
      
    @collider\setLinearVelocity @v, 0
    
      

    
  draw: =>
    r, g, b, a = Graphics.getColor!
    Graphics.setColor @color
    Utils.pushRotate @x, @y, @collider\getAngle!
    Draft\rhombus @x, @y, 1.5*@w, 1.5*@h, 'line'
    Draft\rhombus @x, @y, 0.5*@w, 0.5*@h, 'fill'
    Graphics.pop!
    Graphics.setColor r, g, b, a   

    
  die: =>
    @dead = true
    @area\addGameObject 'BoostCollectEffect', @x, @y, {
      color: @color, w: @w, h: @h}

    @area\addGameObject 'TextEffect', @x + table.random({-1, 1})*@w, @y + table.random({-1, 1})*@h, {
      color: @color, text: '+1 5   BOOST'}
     
  destroy: =>
    super self
