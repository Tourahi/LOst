import remove from table
import insert from table
Manager = MeowC.core.Manager

export class Area
  new: (room, GUI) =>
    @room = room
    @GUI = GUI

    root = Manager\getInstanceRoot!
    for k,widget in pairs @GUI
      root\addChildCore widget

    @gameObjects = {}

  update: (dt) =>
    if Gtimer then Gtimer\update dt
    if @world then @world\update dt

    for i = #@gameObjects, 1, -1
      gameObject = @gameObjects[i]
      gameObject\update dt
      if gameObject.dead
        gameObject\destroy!
        remove @gameObjects, i

  draw: =>
    table.sort @gameObjects, (a, b) ->
      if a.depth == b.depth then return a.creationTime < b.creationTime
      else return a.depth < b.depth
    
    for _, gameObject in ipairs @gameObjects do gameObject\draw!

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


