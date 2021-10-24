export class freqCounter
	new: (sampleP = 1) =>
		@sampleP = sampleP
		@count = 0
		@total = 0
		@lastCount = 0
		@lastTime = -1
		@count = 0
  
	add: =>
		@count += 1
		@total += 1

	get: =>
		now = math.floor love.timer.getTime! / @sampleP
		if now ~= @lastTime
			@lastTime = now
			@lastCount =count
			@count = 0
		@lastCount

	getTotal: =>
		@total

freqCounter