function love.load()
	benchmark = require("benchmark")
	love.graphics.setBackgroundColor(100,100,100)
end


function love.update(dt)
	benchmark.start()

	for i=0,100 do
		print (i, os.time())
	end

	benchmark.finish()
end

function love.draw()
	benchmark.draw()
end

function love.keypressed(key)
	if key == "escape" then love.event.quit() end
end
