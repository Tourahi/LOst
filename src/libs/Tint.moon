-- colors manipulator
-- Color models supported RGB, HSL, HSV

Min = math.min
Max = math.max
Atan = math.atan
Pi = math.pi
Sqrt = math.sqrt
Atan2 = math.atan2
Cos = math.cos
Sin = math.sin
Rad = math.rad
Abs = math.abs

class Tint

  @unpackColor: (p1, ...) =>
    if type(p1) == 'table'
      return unpack p1
    p1, ...
  
  @RGBtoHSL: (...) =>
    r, g, b, a = Tint\unpackColor ...
    
    _min = Min(r, g, b)
    _max = Max(r, g, b)
    dtMax = _max - _min

    h,s,l = nil,nil,nil

    l = (_max+_min)/2 
    
    if dtMax == 0
      h, s = 0, 0
    else
      if l < 0.5
        s = dtMax / (_max + _min)
      else
        s = dtMax / (2 - _max - _min)

      dtR = (((_max - r)/6) + (dtMax/2)) / dtMax 
      dtG = (((_max - g)/6) + (dtMax/2)) / dtMax 
      dtB = (((_max - b)/6) + (dtMax/2)) / dtMax

      if r == _max
        h = dtB - dtG
      elseif g == _max
        h = (1/3) + dtR - dtB
      elseif b == _max
        h = (2/3) + dtB - dtR

      if h < 0 then h += 1
      if h > 1 then h -= 1

    {h, s, l, a}

  @RGBtoHSV: (...) =>
    r, g, b, a = Tint\unpackColor ...

    _min = Min(r, g, b)
    _max = Max(r, g, b)
    dtMax = _max - _min

    h,s,v = nil,nil,nil

    v = _max 

    if dtMax == 0
      h, s = 0, 0
    else
      s = dtMax / _max

      dtR = (((_max - r)/6) + (dtMax/2)) / dtMax 
      dtG = (((_max - g)/6) + (dtMax/2)) / dtMax 
      dtB = (((_max - b)/6) + (dtMax/2)) / dtMax

      if r == _max
        h = dtB - dtG
      elseif g == _max
        h = (1/3) + dtR - dtB
      elseif b == _max
        h = (2/3) + dtB - dtR

      if h < 0 then h += 1
      if h > 1 then h -= 1

    {h, s, v, a}

  @HEXtoRGB: (hex, val) =>
    {
      tonumber(string.sub(hex, 2, 3), 16)/255
      tonumber(string.sub(hex, 4, 5), 16)/255
      tonumber(string.sub(hex, 6, 7), 16)/255
      val or 1
    }

  @HUEtoRBG: (v1, v2, vh) =>
    if vh < 0 then vh += 1
    if vh > 1 then vh -= 1
    if 6*vh < 1 then return v1 + (v2 - v1) * 6 * vh
    if 2*vh < 1 then return v2
    if 3*vh < 2 then return v1 + (v2-v1) * ((2/3)-vh)*6
    v1

  @HSLtoRGB: (...) =>
    h,s,l,a = Tint\unpackColor ...
    r,g,b = nil,nil,nil

    if s == 0
      r = l
      g = l
      b = l
    else
      v1,v2 = nil, nil

      if l < 0.5
        v2 = l*(1+s)
      else
        v2 = (l+s) - (s*l)

      v1 = 2*l-v2

      r = @HUEtoRBG v1, v2, h + (1/3)
      g = @HUEtoRBG v1, v2, h
      b = @HUEtoRBG v1, v2, h - (1/3)

    {r,g,b,a}

  @HSVtoRGB: (...) =>
    h,s,v,a = Tint\unpackColor ...
    r,g,b = nil,nil,nil   

    if s == 0
      r = v
      g = v
      b = v
    else
      vh,vi,v1,v2,v3 = nil,nil,nil,nil,nil
      vh = h*6
      if vh == 6 then vh = 0
      vi = math.floor vh
      v1 = v*(1-s)
      v2 = v*(1-s*(vh-vi))  
      v3 = v*(1-s*(1-(vh-vi)))

      switch vi
        when 0
          r,g,b = v,v3,v1
        when 1
          r,g,b = v2,v,v1
        when 2
          r,g,b = v1,v,v3
        when 3
          r,g,b = v1,v2,v
        when 4
          r,g,b = v3,v1,v
        else
          r,g,b = v,v1,v2

    {r,g,b,a}

  @lighten: (amnt, ...) =>
    h,s,l,a = Tint\RGBtoHSL Tint\unpackColor(...)
    Tint\HSLtoRGB h,s,l+amnt,a

  @darken: (amnt, ...) =>
    h,s,l,a = Tint\RGBtoHSL Tint\unpackColor(...)
    Tint\HSLtoRGB h,s,l-amnt,a

  @saturate: (amnt, ...) =>
    h,s,v,a = Tint\RGBtoHSV Tint\unpackColor(...)
    Tint\HSVtoRGB h,s+amnt,l,a

  @desaturate: (amnt, ...) =>
    h,s,v,a = Tint\RGBtoHSV Tint\unpackColor(...)
    Tint\HSVtoRGB h,s-amnt,l,a

  @hue: (hue, ...) =>
    h,s,l,a = Tint\RGBtoHSL Tint\unpackColor(...)
    Tint\HSLtoRGB hue,s,l,a

  @invert: (...) =>
    r,g,b,a = Tint\unpackColor ...
    1-r, 1-g, 1-b, a

  @invertHue: (...) =>
    h,s,l,a = Tint\RGBtoHSL Tint\unpackColor(...)
    Tint\HSLtoRGB 1-h,s,l,a
