local Ball = require("ball")
local Player = require("player")
local Enemy = require("enemy")

local startTime = love.timer.getTime()
local crtShader
local canvas
local game = { playerScore = 0, enemyScore = 0 }

function love.load()
	love.window.setTitle("Pong Game")
	love.graphics.setDefaultFilter("nearest", "nearest")
	math.randomseed(os.time())

	local font = love.graphics.newFont(42)
	local width, height = love.graphics.getDimensions()

	love.graphics.setFont(font)

	crtShader = love.graphics.newShader("crt.glsl")
	canvas = love.graphics.newCanvas(width, height, { type = "2d", readable = true })

	Ball:load(width, height)
	Player:load(20, 100, width, height)
	Enemy:load(20, 100, height)
end

function love.update(dt)
	local width, height = love.graphics.getDimensions()

	Ball:update(dt, width, height, game)
	Player:update(dt, "up", "down", height)
	Enemy:update(dt, Ball, width, height)

	local player_collision = Player:checkCollision(Ball.x, Ball.y, Ball.radius)
	if player_collision then
		Ball.dx = -Ball.dx
		Ball.x = Ball.x - Player.width
	end

	local enemy_collision = Enemy:checkCollision(Ball.x, Ball.y, Ball.radius)
	if enemy_collision then
		Ball.dx = -Ball.dx
		Ball.x = Ball.x + Enemy.width
	end
end

function love.draw()
	love.graphics.setCanvas(canvas)
	love.graphics.clear(0.937, 0.945, 0.96, 1)
	love.graphics.setColor(0.215, 0.547, 0.398, 1)

	-- love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10)
	-- love.graphics.print("Spped: " .. tostring(Ball.self.speed), 20, 20)
	local width, height = love.graphics.getDimensions()

	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.line(width / 2, 0, width / 2, height / 2, width / 2, height)
	love.graphics.print(game.enemyScore, width / 2 - 100, height / 2)
	love.graphics.print(game.playerScore, width / 2 + 100, height / 2)
	Ball:draw()
	Player:draw()
	Enemy:draw()

	love.graphics.setCanvas()
	love.graphics.setColor({ 100, 33, 56, 1 })
	crtShader:send("millis", love.timer.getTime() - startTime)
	love.graphics.setShader(crtShader)
	love.graphics.draw(canvas, 0, 0)
	love.graphics.setShader()
end

function love.keypressed(key)
	local width, height = love.graphics.getDimensions()
	if key == "r" then
		Ball:load(width, height)
		game.playerScore = 0
		game.enemyScore = 0
	elseif key == "escape" then
		love.event.quit()
	end
end
