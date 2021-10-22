-- input bindings
export Input = assert require 'src/libs/Input'
assert require 'src/libs/Colors'
export input = Input!

input\bindArr {
  'right': 'right'
  'left': 'left'
  }


import random from love.math
M = assert require 'moon'
export Log = assert require 'libs/log/log'
export Dump = M.p

Dump Log

export Graphics = love.graphics
export Window = love.window
export Keyboard = love.keyboard
export Filesystem = love.filesystem

-- Game modules
export Timer = assert require 'libs/EnhancedTimer/EnhancedTimer'
export Camera = assert require 'libs/hump/camera'
export Physics = assert require 'libs/windfield/windfield'

assert require 'src/objects/Area'
assert require 'src/GameObject'


-- rooms
export G_currentRoom = nil


-- Utils

export Utils = assert require 'src/Utils'


export Uid = ->
  f = (x) ->
    r = random(16) - 1
    r = (x == "x") and (r + 1) or (r % 4) + 9
    return ("0123456789abcdef")\sub r, r
  return (("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx")\gsub("[xy]", f))


-- WARN : Can return dicimals
export Random = (min, max) ->
    min, max = min or 0, max or 1
    return (min > max and (love.math.random()*(min - max) + max)) or (love.math.random()*(max - min) + min)


