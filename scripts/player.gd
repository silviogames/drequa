extends Entity

var life_bar = null
var ui_action = null

#action ui stuff

enum ACTIONS { MOVE, ATTACK }


func connect_ui():
	life_bar = get_node("/root/Main/Canvas_GUI/GUI/left_elements/bar/progress_life")
	ui_action = get_node("/root/Main/Canvas_GUI/ui_action")
	
func life_changed():
	if life <= 0:
		main.spawn_message("you are dead")
	else:
		main.spawn_message("you have been attacked")
	life_bar.value = life
	
func _input(event):
	var act = false
	if map.is_idle():
		if event is InputEventKey:
			if event.scancode == KEY_A:
				if not event.pressed:
					ui_action.pressed_action(utils_dir.DIR.LEFT)
					set_target(utils_dir.DIR.LEFT)
					act = true
			if event.scancode == KEY_S:
				if not event.pressed:
					ui_action.pressed_action(utils_dir.DIR.DOWN)
					set_target(utils_dir.DIR.DOWN)
					act = true
			if event.scancode == KEY_W:
				if not event.pressed:
					ui_action.pressed_action(utils_dir.DIR.UP)
					set_target(utils_dir.DIR.UP)
					act = true
			if event.scancode == KEY_D:
				if not event.pressed:
					ui_action.pressed_action(utils_dir.DIR.RIGHT)
					set_target(utils_dir.DIR.RIGHT)
					act = true
			if event.scancode == KEY_Q:
				if not event.pressed:
					act = true
					print("player waiting")

		if act:
			map.start_act()
				
				
func init(init_pos):
	super_init(init_pos)
	max_life = 150
	life = 150
	life_bar.max_value = max_life
	life_bar.value = life

func act():
	pass
	#player is not acting but controlled

func power():
	return 7


