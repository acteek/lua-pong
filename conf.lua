-- conf.lua
-- LÖVE configuration file

function love.conf(t)
	t.version = "11.5" -- LÖVE version (matches your installed version)
	t.console = true -- Enable console (Windows only)

	-- Window settings
	t.window.width = 1080 -- Default window width
	t.window.height = 720 -- Default window height
	t.window.resizable = false -- Allow window resizing
	t.window.minwidth = 800 -- Minimum window width
	t.window.minheight = 600 -- Minimum window height
	t.window.fullscreen = false -- Start in windowed mode
	t.window.vsync = 1 -- Enable vertical sync
end
