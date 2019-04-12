extends Node2D


class_name Entity, "res://tex/test_person.png"
var map = null

var pos = [0,0]

var target_pos = null
var target_axis= 0 # 0 = x, 1 = y
var target_dir = 1 # -1 or 1 

enum DIR { UP, RIGHT, LEFT, DOWN}

func dir_name(dir):
	match dir:
		DIR.UP:
			return "up"
		DIR.RIGHT:
			return "right"
		DIR.DOWN:
			return "down"
		DIR.LEFT:
			return "left"
		_:
			return "none"

func _ready():
	map = get_node("/root/Main/Map")
	map.entities.append(self)
	
	
func init(posx,posy):
	set_pos(posx,posy)

	
func set_pos(tx,ty):
	self.pos = [tx, ty]
	position.x = (pos[0] * 16) + 8
	position.y = (pos[1] * 16) + 8

func set_target(dir):
	# set target tile if none has been set
	var dtx = 0
	var dty = 0

	match dir:
		DIR.UP:
			dtx = 0
			dty = -1
		DIR.RIGHT:
			dtx = 1
			dty = 0
		DIR.DOWN:
			dtx = 0
			dty = 1
		DIR.LEFT:
			dtx = -1
			dty = 0

	if target_pos == null:
		var ntx = pos[0] + dtx
		var nty = pos[1] + dty
		if ntx == pos[0] and nty != pos[1]:
			target_axis = 1
			if nty < pos[1]:
				target_dir = -1
			else:
				target_dir = 1
		elif nty == pos[1] and ntx != pos[0]:
			target_axis = 0
			if ntx < pos[0]:
				target_dir = -1
			else:
				target_dir = 1

		if map.walkable(ntx,nty):
			target_pos = [pos[0] + dtx, pos[1] + dty]
		else:
			print("cannot enter tile at " + String(ntx) + " " + String(nty)) 
			target_pos = null
	else:
		print("cannot set target while moving")


func end_move():
	# transition is over. set current pos to target pos 
	if target_pos != null:
		target_axis = 0
		target_dir = 0
		set_pos(target_pos[0], target_pos[1])
		target_pos = null
	
func move(value):
	# map sends interpolation value for sprite to move its offset
	if target_pos != null:
		position[target_axis] = (pos[target_axis] * 16 + 8 ) + (target_dir * value * 16)


func act():
	# is called by map on every entity to decide what to after player made a step
	print("not implemented by subclass!")

func abs_pos(dir):
	# calculate absolute position from current posiiton of entity and dir offset

	var dtx = 0
	var dty = 0

	match dir:
		DIR.UP:
			dtx = 0
			dty = -1
		DIR.RIGHT:
			dtx = 1
			dty = 0
		DIR.DOWN:
			dtx = 0
			dty = 1
		DIR.LEFT:
			dtx = -1
			dty = 0
	return [pos[0] + dtx, pos[1] + dty]
	
func move_to(move_pos):
	# try to get to position without actual pathfinding. walk into direction of move_pos
	# return a direction to get there

	var dx = move_pos[0] - pos[0]
	var dy = move_pos[1] - pos[1]
	if dx == 0 and dy == 0:
		# already at pos
		return [-1,-1]

	var mx = -1
	var my = -1
	if dx > 0:
		mx = DIR.RIGHT
	elif dx < 0:
		mx =  DIR.LEFT
	else:
		mx = -1

	if dy > 0:
		my = DIR.DOWN
	elif dy < 0:
		my = DIR.UP
	else:
		my = -1

	if abs(dx) >= abs(dy):
		return [mx, my]
	else:
		return [my, mx]

