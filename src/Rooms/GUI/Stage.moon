ProgressBar = assert require 'src/GUI/Controls/ProgressBar'

-- GUI
GUI = {}
GUI.bBar = ProgressBar!
with GUI.bBar
  \setSize 50, 5
  \setPos G_baseW - 55, G_baseH - 20
  \setMaxValue 100
  \setDangerZone 20


GUI
