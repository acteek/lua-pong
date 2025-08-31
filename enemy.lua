local Enemy = {}

function Enemy:load(width, height, screenHeight)
	-- Position
	self.x = 5
	self.y = screenHeight / 2 - height / 2
	self.width = width
	self.height = height

	-- Movement
	self.speed = 550
	self.friction = 0.6
	self.hitSound = love.audio.newSource("sounds/hit-3.wav", "stream")
end

function Enemy:update(dt, ball, screenWidth, screenHeight)
	if ball.x > screenWidth / 2 then
		return
	end

	local enemyCenter = self.y + self.height / 2
	if enemyCenter < ball.y then
		self.y = math.min(screenHeight - (self.height + 5), self.y + self.speed * self.friction * dt)
	elseif enemyCenter > ball.y then
		self.y = math.max(5, self.y - self.speed * self.friction * dt)
	end
end

function Enemy:checkCollision(ballX, ballY, ballRadius)
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

function Enemy:draw()
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.rectangle("line", self.x, self.y, self.width + 1, self.height + 1)
	love.graphics.setColor(0, 0, 0, 0.25)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Enemy
