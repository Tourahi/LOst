Control = MeowC.core.Control
Theme = MeowC.core.Theme

ProgressBar = Control\extend "ProgressBar",{
  value: 0
  minValue: 0
  maxValue: 100
  color: 0
  background: 0
}


with ProgressBar
  .init = =>
    @super.init(self)
    @color = Colors.blue
    @background = Colors.white
    
    @setEnabled true
    @setClip true

    -- Events
    @on "UI_DRAW", @onDraw, self
    -- @on "UI_UPDATE", @onDraw, self

  .onDraw = =>
    box = @getBoundingBox!
    r, g, b, a = Graphics.getColor!

    Graphics.setColor @background
    Graphics.rectangle "fill", box\getX!, box\getY!, box\getWidth!, box\getHeight!

    barW = @value / (@maxValue - @minValue) * box\getWidth!
    if barW < 0
      barW = 0
    elseif barW > box\getWidth!
      barW = box\getWidth!

    Graphics.setColor @color
    Graphics.rectangle "fill", box\getX!, box\getY!, barW, box\getHeight!
    Graphics.setColor r, g, b, a


  .setColor = (c) =>
    @color = c
   
  .setBackground = (b) =>
    @background = b

  .setValue = (v) =>
    @value = v

  .setMaxValue = (v) =>
    @maxValue = value