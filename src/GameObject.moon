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

  update: (dt) =>
    if @timer
      @timer\update dt

  -- draw:


