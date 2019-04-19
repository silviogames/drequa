extends Node2D

var gui_left_elements = null
var gui_tip = load("res://scenes/gui_tip.tscn")

func _ready():
	OS.center_window()
	gui_left_elements = $Canvas_GUI/GUI/left_elements
	print("gui_le ", gui_left_elements)
	
	
func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
		
	# zoom camera
	if Input.is_key_pressed(KEY_UP):
		var camera = $Objects/Player/camera
		camera.zoom += Vector2(-delta, -delta)
		if camera.zoom.x <= 0.1:
			camera.zoom = Vector2(0.1 , 0.1)
	elif Input.is_key_pressed(KEY_DOWN):
		var camera = $Objects/Player/camera
		camera.zoom += Vector2(delta, delta)
		if camera.zoom.x >= 1:
			camera.zoom = Vector2(1 , 1)
		

func spawn_message(message):
	var gt = gui_tip.instance()
	gt.set_message(message)
	gui_left_elements.add_child(gt)
		
func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_N:
			if not event.pressed:
				var gt = gui_tip.instance()
				gt.set_message("hello world")
				gui_left_elements.add_child(gt)
		


