local Player = {}

function Player:load(width, height, screenWidth, screenHeight)
	-- Position
	self.x = screenWidth - width - 5
	self.y = screenHeight / 2 - height / 2
	self.width = width
	self.height = height

	-- Movement
	self.speed = 500
	self.hitSound = love.audio.newSource("sounds/hit-2.wav", "stream")
end

function Player:update(dt, upKey, downKey, screenHeight)
	if love.keyboard.isDown(upKey) then
		self.y = math.max(5, self.y - self.speed * dt)
	elseif love.keyboard.isDown(downKey) then
		self.y = math.min(screenHeight - (self.height + 5), self.y + self.speed * dt)
	end
end

function Player:checkCollision(ballX, ballY, ballRadius)
	if
		ballX + ballRadius > self.x
		and ballX - ballRadius < self.x + self.width
		and ballY + ballRadius > self.y
		and ballY - ballRadius < self.y + self.height
	then
		self.hitSound:play()
		return true
	end
	return false
end

function Player:draw()
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.rectangle("line", self.x, self.y, self.width + 1, self.height + 1)
	love.graphics.setColor(0, 0, 0, 0.25)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Player
