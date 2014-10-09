actor = {}
function actor.new(x, y, w, h)
	local t = {}
	t.x = x
	t.y = y
	t.w = w
	t.h = h
	t.s = 0
	t.position = 0
	t.speed = 0
	t.rect = {left = x, right = x + w, top = y, bottom = y + h}
	t.changed = 0
	setmetatable(t, actor)
	return t
end

function actor:stop()
	self.speed = 0
end

function actor:move(position, speed)
	self.position = position
	self.speed = speed
end

rr = {left = 100, right = 800, top = 100, bottom = 800}

function point4inrect(x, y, w, h, outrect)
	if (outrect.left <= x) or (outrect.top >= y) 
		or (outrect.right >= x) or (outrect.bottom >= y) then
		return true
	else
		return false
	end
end

function actor:update()
	self.s = self.s + self.speed
	self.x = self.x + math.cos(self.position * 3.14 / 180) * self.s
	self.y = self.y - math.sin(self.position * 3.14 / 180) * self.s
	--point4inrect(self.x, self.y, self.w, self.h, rr)
	self.changed = self.changed + 1
	if self.changed > 20  then
		self.position = (self.position + 180) % 360
		self.s = 1
		self.changed = 0
	end
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
	actornode = {}

}

function scenemgr.init(w, h, level)	 
	local rect = {left = 0, top = 0, right = w, bottom = h}
	scenemgr.actornode.rect = rect
	split(scenemgr.actornode, rect, level)
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
	scenemgr.actorlist[#scenemgr.actorlist + 1] = actor
	scenemgr:add_node(actor)
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
	local n = find_node(scenemgr.actornode, actor)
	if not n.actors then n.actors = {} end
	n.actors[#n.actors + 1] = actor
end

function scenemgr:delete_actor(actor)
	local n = find_node(scenemgr.actornode, actor)
	for i, v in ipairs(n.actors) do
		if v == actor then
			table.remove(n, n.actors, i)
			return
		end
	end
	table.remove(scenemgr.actorlist, actor)
end

function scenemgr.update_actor()
	for i, v in ipairs(scenemgr.actorlist) do
		actor.update(v)
	
	end	
end

function scenemgr.add_effect(effect)
	-- body
end

function scenemgr.update_effect()
	-- body
end



