function love.load()
	benchmark = require("benchmark")
	love.graphics.setBackgroundColor(100,100,100)

	-- create 2000 objects to move about
	circles = {}
	for i=0,2000 do
		local size = 20
		table.insert(circles, {
			size = size,
			x = love.math.random(size,love.graphics.getWidth()-size),
			y = love.math.random(size,love.graphics.getHeight()-size),
			xvel = love.math.random(-50,50),
			yvel = love.math.random(-50,50),
			rgb = {love.math.random(200,255),love.math.random(150,200),love.math.random(100,150)}
			})
	end
end


function love.update(dt)
	benchmark.start()

	--[[ some code to process
	--]]
	for _,s in ipairs(circles) do
		s.x = s.x + s.xvel *dt
		s.y = s.y + s.yvel *dt

		if s.x-s.size < 0 or s.x+s.size > love.graphics.getWidth() then 
			s.xvel = -s.xvel 
		end
		if s.y-s.size < 0 or s.y+s.size > love.graphics.getHeight() then 
			s.yvel = -s.yvel
		end
	end

	benchmark.finish()
end

function love.draw()

	for _,s in ipairs(circles) do
		love.graphics.setColor(s.rgb[1],s.rgb[2],s.rgb[3],255)
		love.graphics.circle("fill",s.x,s.y,s.size)
		love.graphics.setColor(0,0,0,255)
		love.graphics.circle("line",s.x,s.y,s.size)
	end
		
	benchmark.draw()
end

function love.keypressed(key)
	if key == "escape" then love.event.quit() end
end
