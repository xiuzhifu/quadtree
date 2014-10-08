local actor = {
	x = 0,
	y = 0,
	w = 1,
	h = 1, 
	position = 0,
	speed = 0,
}

function actor.new(x, y, w, h)
	local t = {}
	setmetetable(t, actor)
	t.x = x
	t.y = y
	t.w = w
	t.h = h
	t.s = 0
	actor.rect = {left = x, right = x + w, top = y, bottom = y + h}
	
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
	actorlist = {},
	actornode = nil

}

function scenemgr:init(w, h)
	local t = {}
	--setmetetable(t, scenenode)
	self.actornode = t
	local rect = {left = 0, top = 0, right = w, bottom = h}
	node.rect = rect
	split(self.actornode, rect)
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


function scenemgr:add_actor(actor)
	self.actorlist[#self.actorlist + 1] = actor
	self.add_node(self.actornode, actor)
end

function rectinrect(inrect, outrect)
	if (outrect.left < inrect.left) and (outrect.top > inrect.top) 
		and (outrect.right > inrect.right) and (outrect.bottom > inrect.bottom) then
		return true
	else
		return false
	end
end

function find_node(node, actor)
	if (node.level > 1)  and rectinrect(actor.rect, node.rect) then
		if actor.rect.left > node.rect.left + (node.rect.right - node.rect.left) / 2 then
			if actor.rect.top > node.rect.top + (node.rect.bottom - node.rect.top) / 2 then
				find_node(node.quadnode[rt], actor)
			else
				find_node(node.quadnode[rb], actor)
			end
		else
			if actor.rect.top > node.rect.top + (node.rect.bottom - node.rect.top) / 2 then
				find_node(node.quadnode[lt], actor)
			else
				find_node(node.quadnode[lb], actor)
			end
		end
	end
	return node
end

function scenemgr:add_node(actor)
	local n = find_node(self.actornode, actor)
	n.actors[#n.actors + 1] = actor
end

function scenemgr:delete_actor(actor)
	local n = find_node(self.actornode, actor)
	for i, v in n.actors do
		if v == actor then
			table.remove(n, n.actors, i)
			return
		end
	end
	table.remove(self.actorlist, actor)
end

function scenemgr.update_actor(node)
	for i, v in node.actors do
		v.s = v.s + s.speed
		v.x = v.x + math.sin(v.position * math.pi / 180) * v.s
		v.y = v.y + math.cos(v.position * math.pi / 180) * v.s
	
	end
	if node.level - 1 <= 0 then return end
	print_tree(node.quadnode[rt])
	print_tree(node.quadnode[lt])
	print_tree(node.quadnode[lb])
	print_tree(node.quadnode[rb])
	
end

function scenemgr.add_effect(effect)
	-- body
end

function scenemgr.update_effect()
	-- body
end



