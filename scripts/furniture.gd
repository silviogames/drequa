extends Node2D
# furniture class. is also an entity but does not move by itself
# abstract class. furniture extends this
# furniture can have various properties like lootable, etc.

class_name Furniture

const utils = preload("res://scripts/utils.gd")
const utils_dir = preload("res://scripts/utils_dir.gd")

var pos = [-1, -1]
var target_pos = null
var target_axis= 0 # 0 = x, 1 = y
var target_dir = 1 # -1 or 1 

var object_name = "none"
var properties = {}

var map = null
var main = null

enum PROP {LOOT, PUSH}

func _ready():
	map = get_node("/root/Main/Map")
	main = get_node("/root/Main")

func set_pos(new_pos):
	self.pos = new_pos
	position.x = (pos[0] * 16) + 8
	position.y = (pos[1] * 16) + 8

func super_init(init_pos, obj_name, props):
	# props is array of properties
	# subclass should call this method!

	set_pos(init_pos)
	self.object_name = obj_name
	for pr in props:
		self.properties[pr] = true

func push(dir):
	# move furniture if pushable
	if PROP.PUSH in properties:
		utils_dir.create_target_dir(self, dir, map)
		print("can push this furniture")
	else:
		print("cannot push this furniture")


func act():
	pass

func move(value):
	# map sends interpolation value for action of this step (walk, attack)
	if target_pos != null:
		position[target_axis] = (pos[target_axis] * 16 + 8 ) + (target_dir * value * 16)

func end_move():
	# transition is over. set current pos to target pos 
	if target_pos != null:
		target_axis = 0
		target_dir = 0
		set_pos(target_pos)
		target_pos = null
	$Sprite.position.y = 0
	$Sprite.position.x = 0
	pass

func plan_move():
	print("furniture planning move")
	pass

	



