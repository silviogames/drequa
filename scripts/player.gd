extends Entity

func _ready():
	print("player ready")
	
func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_A:
			if not event.pressed:
				move(-1)
		if event.scancode == KEY_S:
			if not event.pressed:
				move(0, 1)
		if event.scancode == KEY_W:
			if not event.pressed:
				move(0, -1)
		if event.scancode == KEY_D:
			if not event.pressed:
				move(1)
		if event.scancode == KEY_SPACE:
			if not event.pressed:
				var map = get_map()
				print("walk ", map.walkable(tx,ty))
				# check if floor is walkable
				
				

func get_map():
	# util method for quick map access
	return get_node("/root/Main/Map")
