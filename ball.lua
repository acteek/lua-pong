local Ball = {}

function Ball:load(width, height, speed)
	-- Position
	self.x = height / 2
	self.y = width / 2
	self.radius = 15

	-- Movement
	self.speed = speed or 600
	self.angles = { 20, 30, 40, 50, 60, 120, 130, 140, 150, 160 }

	local angleIndex = math.random(#self.angles)
	self.angle = math.rad(self.angles[angleIndex])

	-- Direction
	self.dx = self.speed * math.cos(self.angle)
	self.dy = self.speed * math.sin(self.angle)
	self.loseSound = love.audio.newSource("sounds/lose.wav", "stream")
	self.wallHitSound = love.audio.newSource("sounds/hit-1.wav", "stream")
	self.sprite = love.graphics.newImage("assets/ball.png")
end

function Ball:update(dt, width, height, game)
	self.x = self.x + self.dx * dt
	self.y = self.y + self.dy * dt

	-- Bounce off top and bottom walls
	if self.y - self.radius < 0 then
		self.y = self.radius
		self.dy = -self.dy
		self.wallHitSound:play()
	elseif self.y + self.radius > height then
		self.y = height - self.radius
		self.dy = -self.dy
		self.wallHitSound:play()
	elseif self.x - self.radius < 0 then
		self.loseSound:play()
		Ball:load(width, height, self.speed)
		game.playerScore = game.playerScore + 1
	elseif self.x + self.radius > width then
		self.loseSound:play()
		Ball:load(width, height, self.speed)
		game.enemyScore = game.enemyScore + 1
	end
end

function Ball:draw()
	-- Ball shadow
	love.graphics.setColor(0, 0, 0, 0.2)
	love.graphics.circle("fill", self.x - self.dx * 0.02, self.y - self.dy * 0.02, self.radius)
	-- Ball
	love.graphics.setColor(0.82, 1.0, 0.27, 1)
	love.graphics.circle("fill", self.x, self.y, self.radius)
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.circle("line", self.x + 1, self.y + 1, self.radius)
end

return Ball
