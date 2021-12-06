import getTime from love.timer

export class GameObject
  new: (area, x, y, opts = {}) =>
    if opts
      for k, v in pairs opts
        self[k] = v

    @area = area
    @x, @y = x, y
    @id  = Uid!
    @creationTime = getTime!
    @timer = Timer!
    @dead = false
    @depth = 50
    @collider = nil

  update: (dt) =>
    if @timer
      @timer\update dt
    if @collider
      @x, @y = @collider\getPosition!

  draw: =>

  destroy: =>
    @timer\destroy!
    if @collider
      @collider\destroy!
    @collider = nil

