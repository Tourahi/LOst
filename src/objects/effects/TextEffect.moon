export class TextEffect extends GameObject
  new: (area, x, y, opts) =>
    super area, x, y, opts
    @depth = 100
    @text = opts.text or ""
    @font = Graphics.newFont Fonts.Connection, 8

    @w, @h = @font\getWidth(@text), @font\getHeight(@text)
    @characters = {}
    @color = opts.color or Colors.white
    @bgColors = {}
    @fgColors = {}

    for i = 1, #@text
      table.insert @characters, @text\utf8sub(i ,i)
    
    allInfoText = @area\filterGameObjects (o) ->
      if o.__class.__name == 'Ammo' and o.id ~= @id
          return true 
    
    collidesWithOtherTextEffects = ->
      for _, text in ipairs allInfoText
        return Utils.rectOverlapping @x, @y, @x + @w, @y +@h, text.x, text.y, 
          text.x + text.w, text.y + text.h

    while collidesWithOtherTextEffects!
      @x = @x + table.random({-1, 0, 1}) *@w
      @y = @y + table.random({-1, 0, 1}) *@h

    @visible = true
    @timer\after 0.70, ->
      @timer\every 0.05, -> @visible = not @visible, 6
      @timer\after 0.35, -> @visible = true

      @timer\every 0.035, ->
        randomChars = '0123456789!@#$%¨&*()-=+[]^~/;?><.,|abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWYXZ'
        for i, char in ipairs @characters
          if love.math.random(1, 20) <= 1
            r = love.math.random(1, #randomChars)
            @characters[i] = randomChars\utf8sub r, r
          else
            @characters[i] = char

          if love.math.random(1, 10) <= 1
            @bgColors[i] = Utils.randomTableValue(Colors)
    

          if love.math.random(1, 10) <= 2
            @fgColors[i] = Utils.randomTableValue(Colors)


          

    @timer\after 1.10, -> @dead = true

          
  update: (dt) =>
    super dt


  draw: =>
    if not @visible then return

    Graphics.setFont @font

    r,g,b,a = Graphics.getColor!

    for i = 1, #@characters
      width = 0
      if i > 1
        for j = 1, i - 1
          width += @font\getWidth @characters[j]

      if @bgColors[i]
        Graphics.setColor @bgColors[i]
        Graphics.rectangle 'fill', @x + @w, @y - @font\getHeight!/2,
          @font\getWidth(@characters[i]), @font\getHeight! 
        
      Graphics.setColor @fgColors[i] or @color or Colors.white
      Graphics.print @characters[i], @x + width, @y, 0, 1, 1, 0, @font\getHeight!/2

    Graphics.setColor r,g,b,a
      
  destroy: =>
    super self