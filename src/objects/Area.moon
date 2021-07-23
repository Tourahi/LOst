import remove from table
import insert from table

export class Area
  new: ( room ) =>
    @room = room
    @gameObjects = {}

  update: (dt) =>
    if @world
      @world\update dt
    for i = #@gameObjects, 1, -1
      gameObject = @gameObjects[i]
      gameObject\update dt
      if gameObject.dead
        remove @gameObjects, i

  draw: =>
    if @world
      @world\draw!
    for _, gameObject in ipairs @gameObjects
      gameObject\draw!


  addGameObject: (gameObjectType, x, y, opts = {}) =>
    gameObject = _G[gameObjectType](self, x or 0, y or 0, opts)
    insert @gameObjects, gameObject
    gameObject

  addPhysicsWorld: =>
    @world = Physics.newWorld 0, 0, true

