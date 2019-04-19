extends Node2D


const utils = preload("res://scripts/utils.gd")
const utils_dir = preload("res://scripts/utils_dir.gd")

class_name Entity, "res://tex/test_person.png"
var map = null
var main = null
var globals = null

var pos = [0,0]

var max_life = 100
var life = 100

var target_pos = null
var target_axis= 0 # 0 = x, 1 = y
var target_dir = 1 # -1 or 1 

var attack_dir = null
var attack_target = null


func _ready():
	map = get_node("/root/Main/Map")
	main = get_node("/root/Main")
	globals = get_node("/root/Main/Globals")

	
	
func super_init(init_pos):
	set_pos(init_pos)
	
func set_pos(new_pos):
	self.pos = new_pos
	position.x = (pos[0] * 16) + 8
	position.y = (pos[1] * 16) + 8

func set_target(dir):
	# set target tile if none has been set
	var dtx = 0
	var dty = 0

	match dir:
		utils_dir.DIR.UP:
			dtx = 0
			dty = -1
		utils_dir.DIR.RIGHT:
			dtx = 1
			dty = 0
		utils_dir.DIR.DOWN:
			dtx = 0
			dty = 1
		utils_dir.DIR.LEFT:
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
		set_pos(target_pos)
		target_pos = null
	$Sprite.position.y = 0
	$Sprite.position.x = 0

	if attack_target != null:
		var attack_pos = utils_dir.abs_pos(attack_dir, pos)
		map.attack_at(attack_pos, self, attack_target)
		

	
func move(value):
	# map sends interpolation value for action of this step (walk, attack)
	if target_pos != null:
		position[target_axis] = (pos[target_axis] * 16 + 8 ) + (target_dir * value * 16)
		if target_axis == 0:
			$Sprite.position.y = -sin(value * PI ) * 5
	if attack_dir != null:
		$Sprite.position[utils_dir.dir_to_axis(attack_dir)] = utils_dir.dir_to_sign(attack_dir) * value * 8
		



func act():
	# is called by map on every entity to decide what to after player made a step
	print("not implemented by subclass!")

func attack(attacker, victim):
	if utils.next_to(attacker.pos, victim.pos):
		print("fighters are next to each other")
	else:
		print("fighters are NOT next to each other!")


func get_next_pos():
	if target_pos == null:
		return pos
	else:
		return target_pos
	
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
		mx = utils_dir.DIR.RIGHT
	elif dx < 0:
		mx =  utils_dir.DIR.LEFT
	else:
		mx = -1

	if dy > 0:
		my = utils_dir.DIR.DOWN
	elif dy < 0:
		my = utils_dir.DIR.UP
	else:
		my = -1

	if abs(dx) >= abs(dy):
		return [mx, my]
	else:
		return [my, mx]


func power():
	print("func power not implemented by child!")
	return 0

func hit(power):
	life -= power
	if life < 0:
		life = 0
		print("entity dead: ",self)
	else:
		print("entity hit ", self)
		print("life left: ", life)
	life_changed()
	
func life_changed():
	# abstract class only used by player for now to update life bar in ui
	pass


