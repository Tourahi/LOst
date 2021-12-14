follow = (dt, p) =>
  if @x < 0 then @die!
  if @y < 0 then @die!
  if @x > G_baseW then @die!
  if @y > G_baseH then @die!

  @v = math.min @v + @a*dt, @maxV

  if input\down 'left'
      @r = @r - @rv*dt
  if input\down 'right'
      @r = @r + @rv*dt

  if input\pressed 's'
      @offsetFromPlayer = -@offsetFromPlayer

  projectileHeading = Vector2D(@collider\getLinearVelocity!)\norm! or Vector2D.zero!
  angle = math.atan2 (p.y + @offsetFromPlayer.x) - @y, (p.x + @offsetFromPlayer.y) - @x
  toTargetHeading = Vector2D(math.cos(angle), math.sin(angle))\norm!
  finalHeading = (projectileHeading + 0.1*toTargetHeading)\norm!
  @collider\setLinearVelocity @v * finalHeading.x, @v * finalHeading.y


follow
