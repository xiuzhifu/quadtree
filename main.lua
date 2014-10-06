-----------------------
-- NO: A game of numbers
-- Created: 23.08.08 by Michael Enger
-- Version: 0.2
-- Website: http://www.facemeandscream.com
-- Licence: ZLIB
-----------------------
-- This is the main file where we enter the game.
-----------------------
require "scenemgr"

function love.load()
	love.window.setMode(1000, 800, {resizable=true, vsync=false, minwidth=400, minheight=300})
end
local rect = {left = 0, top = 0, right = 1000, bottom = 800}

mynode = {}
mynode.rect = rect
split(mynode, rect, 5)
color = {}
color[0] = {0, 255, 0, 255}
color[1] = {255, 0, 0, 255}
color[2] = {0, 0, 255, 255}
color[3] = {255, 0, 0, 255}
color[4] = {0, 0, 255, 255}
local i = 1
function print_tree2(node)
	if node.rect then 		
		love.graphics.rectangle("line", node.rect.left, node.rect.top, 
			node.rect.right - node.rect.left, node.rect.bottom - node.rect.top)
	else
		return
	end

	if not node.quadnode then 
		i = i + 1	
		love.graphics.print(i, node.rect.left + 5, node.rect.top + 5)
	return end
	love.graphics.setColor(color[1])
	print_tree2(node.quadnode[rt])
	love.graphics.setColor(color[2])
	print_tree2(node.quadnode[lt])
	love.graphics.setColor(color[3])
	print_tree2(node.quadnode[lb])
	love.graphics.setColor(color[4])
	print_tree2(node.quadnode[rb])
end
function love.draw()	
	i = 0
	love.graphics.setColor(color[0])
	print_tree2(mynode)
	
end

function love.update(dt)

end

function love.mousepressed(x, y, button)

end

function love.keypressed(key)
	
	if key == "f4" and (love.keyboard.isDown("ralt") or love.keyboard.isDown("lalt")) then
		love.event.push("q")
	end
end
