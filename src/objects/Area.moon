import remove from table
import insert from table
Manager = MeowC.core.Manager

export class Area
  new: ( room ) =>
    @room = room
    @gameObjects = {}

  update: (dt) =>
    if Gtimer
      Gtimer\update dt
    if @world
      @world\update dt
    for i = #@gameObjects, 1, -1
      gameObject = @gameObjects[i]
      with gameObject
        \update dt
      if gameObject.dead
        gameObject\destroy!
        remove @gameObjects, i

  draw: =>
    for _, gameObject in ipairs @gameObjects
      gameObject\draw!


  addGameObject: (gameObjectType, x = 0, y = 0, opts = {}) =>
    gameObject = _G[gameObjectType](self, x, y, opts)
    insert @gameObjects, gameObject
    gameObject


  getCamera: =>
    @room.camera
  
  getRoom: =>
    @room

  addPhysicsWorld: =>
    @world = Physics.newWorld 0, 0, true

  destroy: =>
    for i = #@gameObject, 1, -1
      gameObj = @gameObjects[i]
      gameObj\destroy!
      remove @gameObjects, i
    
    @gameObjects = {}

    if @world
      @world\destroy!
      @world = nil


