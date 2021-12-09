export class TextEffect extends GameObject
  new: (area, x, y, opts) =>
    super area, x, y, opts
    @depth = 100
    @text = opts.text or ""
    @font = Graphics.newFont Fonts.Connection, 8

    @w, @h = @font\getWidth(@text), @font\getHeight(@text)
    @characters = {}
    @bgColor = opts.bgColor or {}
    @fgColor = opts.fgColor or {}

    for i = 1, #@text
        table.insert @characters, @text\utf8sub(i ,i)
    
    allInfoText = @area\filterGameObjects (o) ->
        if o.__class.__name == 'Ammo' and o.id ~= @id
            return true 
    


    @r = opts.r or random 4, 6
    @timer\tween opts.d or random(0.3, 0.5), self, {r: 0}, 'linear', -> @dead = true

  update: (dt) =>
    super dt