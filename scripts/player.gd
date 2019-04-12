extends Entity

func _ready():
	init(1,1)
	pass
	
func _input(event):
	var moved = false
	if event is InputEventKey:
		if event.scancode == KEY_A:
			if not event.pressed:
				set_target(DIR.LEFT)
				moved = true
		if event.scancode == KEY_S:
			if not event.pressed:
				set_target(DIR.DOWN)
				moved = true
		if event.scancode == KEY_W:
			if not event.pressed:
				set_target(DIR.UP)
				moved = true
		if event.scancode == KEY_D:
			if not event.pressed:
				set_target(DIR.RIGHT)
				moved = true
		if event.scancode == KEY_T:
			if not event.pressed:
				var dirs = move_to([1,1])
				print("dirs ", dirs)

	if moved:
		map.start_move()
				
				
func init(posx,posy):
	posx = 1
	posy = 1
	.init(posx,posy)
	map.player = self

func act():
	pass
	#player is not acting but controlled


