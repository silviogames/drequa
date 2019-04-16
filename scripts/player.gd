extends Entity

var life_bar = null

func _ready():
	life_bar = get_node("/root/Main/Canvas_GUI/GUI/left_elements/bar/progress_life")
	init(1,1)
	
func life_changed():
	life_bar.value = life
	
func _input(event):
	var act = false
	if event is InputEventKey:
		if event.scancode == KEY_A:
			if not event.pressed:
				set_target(DIR.LEFT)
				act = true
		if event.scancode == KEY_S:
			if not event.pressed:
				set_target(DIR.DOWN)
				act = true
		if event.scancode == KEY_W:
			if not event.pressed:
				set_target(DIR.UP)
				act = true
		if event.scancode == KEY_D:
			if not event.pressed:
				set_target(DIR.RIGHT)
				act = true
		if event.scancode == KEY_Q:
			if not event.pressed:
				act = true
				print("player waiting")

	if act:
		map.start_act()
				
				
func init(posx,posy):
	posx = 1
	posy = 1
	.init(posx,posy)
	map.player = self
	max_life = 150
	life = 150
	life_bar.max_value = max_life
	life_bar.value = life

func act():
	pass
	#player is not acting but controlled

func power():
	return 7


