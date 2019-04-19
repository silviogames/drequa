extends Node2D
# furniture class. is also an entity but does not move by itself
# abstract class. furniture extends this
# furniture can have various properties like lootable, etc.

class_name Furniture

var pos = [-1, -1]
var target_pos = null

var object_name = "none"
var properties = {}

var map = null
var main = null

enum PROP {LOOT, PUSH}

func _ready():
	map = get_node("/root/Main/Map")
	main = get_node("/root/Main")


func super_init(pos, obj_name, props):
	# props is array of properties
	# subclass should call this method!
	map.entities.append(self)

	self.pos = pos
	self.object_name = obj_name
	for pr in props:
		self.properties[pr] = true

func push(dir):
	# move furniture if pushable
	pass




	



