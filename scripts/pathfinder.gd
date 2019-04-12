extends Node

# node calculates paths for all entities in queue
const utils = preload("res://scripts/utils.gd")

var queue = {}

func _ready():
	pass

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_P:
			if not event.pressed:
				var id = calc(1,1)

func calc(pos_start, pos_end):
	# return -1 if path invalid
	var id = find_free_id()	
	queue[id] = 0
	return id


func find_free_id():
	# iterate over dict until free id is found
	var id = 0
	while true:
		if not id in queue:
			return id
		id+= 1



