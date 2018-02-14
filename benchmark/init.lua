benchmark = {}

benchmark.ticks = {}
benchmark.total = 200 --width of widget / number of ticks in history
benchmark.multiplier = 10
benchmark.canvas = love.graphics.newCanvas(benchmark.total,50)

function benchmark.start()
	benchmark.tick_start = love.timer.getTime()*1000
end

function benchmark.finish()
	-- don't exceed benchmark.total 
	if #benchmark.ticks > benchmark.total then
		table.remove(benchmark.ticks,1)
	end

	-- calculate average latency
	local average = 0
	for i,tick in ipairs(benchmark.ticks) do
		average = average + tick
	end

	benchmark.average = average/#benchmark.ticks

	-- add the most recent tick
	table.insert(benchmark.ticks,
		love.timer.getTime( )*1000 - benchmark.tick_start
	)

end

function benchmark.draw()
	love.graphics.setCanvas(benchmark.canvas)
	love.graphics.setColor(0,0,0,200)
	local font = love.graphics.getFont()
	love.graphics.setFont(love.graphics.newFont(10))

	-- fill background
	love.graphics.rectangle(
		"fill",
		0,
		0,
		benchmark.canvas:getWidth(),
		benchmark.canvas:getHeight()
	)
	
	-- draw the ticks as lines
	love.graphics.setColor(0,255,0,255)
	for i,tick in ipairs(benchmark.ticks) do
		love.graphics.line(
			0+i,
			benchmark.canvas:getHeight(), 
			0+i,
			benchmark.canvas:getHeight()-tick*benchmark.multiplier
		)
	end		

	-- print average ms
	love.graphics.setColor(255,255,255,255)
	love.graphics.print("avg: "..benchmark.average.."ms",5,5)
	love.graphics.setFont(font)

	love.graphics.setCanvas()

	-- draw benchmark widget
	love.graphics.draw(	
		benchmark.canvas, 
		love.graphics.getWidth()-benchmark.canvas:getWidth()-10,
		10
	)
end

return benchmark
