local actor = {
	x = 0,
	y = 0,
	w = 1;
	h = 1; 
	position = 0;
	speed = 0;
}

function actor.new()
	local t = {}
	setmetetable(t, actor)
	
end

function actor:stop()
	self.speed = 0
end

function actor:move(position, speed)
	self.position = position
	self.speed = speed
end

 rt = 1
 lt = 2
 lb = 3
 rb = 4

local scenenode = {
	quadnode = nil,
	rect = nil,
	level = 0,
	actors = nil
}

scenemgr = {
	firstnode = nil

}

function scenemgr:init(w, h)
	local t = {}
	--setmetetable(t, scenenode)
	self.firstnode = t
	local rect = {left = 0, top = 0, right = w, bottom = h}
	node.rect = rect
	split(self.firstnode, rect)
end

function split(node, r, level)
	node.level = level
	node.quadnode = {}
	local t
	t = {left = r.left + (r.right - r.left) / 2, top = r.top}
	t.right = t.left + (r.right - r.left) / 2
	t.bottom = t.top + (r.bottom - r.top) / 2
	node.quadnode[rt] = {}
	node.quadnode[rt].rect = t

	t = {left = r.left, top = r.top}
	t.right = t.left + (r.right - r.left) / 2
	t.bottom = t.top + (r.bottom - r.top) / 2
	node.quadnode[lt] = {}
	node.quadnode[lt].rect = t

	t = {left = r.left, top = r.top + (r.bottom - r.top) / 2}
	t.right = t.left + (r.right - r.left) / 2
	t.bottom = t.top + (r.bottom - r.top) / 2
	node.quadnode[lb] = {}
	node.quadnode[lb].rect = t

	t = {left = r.left + (r.right - r.left) / 2, top = r.top + (r.bottom - r.top) / 2}
	t.right = t.left + (r.right - r.left) / 2
	t.bottom = t.top + (r.bottom - r.top) /2
	node.quadnode[rb] = {}
	node.quadnode[rb].rect = t
	if level - 1 > 0 then
		split(node.quadnode[rt], node.quadnode[rt].rect, level - 1)
		split(node.quadnode[lt], node.quadnode[lt].rect, level - 1)
		split(node.quadnode[lb], node.quadnode[lb].rect, level - 1)
		split(node.quadnode[rb], node.quadnode[rb].rect, level - 1)
	end
end

function print_tree(node)
	if node.rect then 
		print(node.rect.left, node.rect.top, node.rect.right, node.rect.bottom)
	else
		return
	end
	if not node.quadnode then return end
	print_tree(node.quadnode[rt])
	print_tree(node.quadnode[lt])
	print_tree(node.quadnode[lb])
	print_tree(node.quadnode[rb])
end

--scenemgr:init(50, 100)

--print_tree(scenemgr.firstnode)


function scenemgr.add_actor(actor)
	-- body
end

function scenemgr.delete_actor(actor)
end

function scenemgr.update_actor()
	-- body
end

function scenemgr.add_effect(effect)
	-- body
end

function scenemgr.update_effect()
	-- body
end



