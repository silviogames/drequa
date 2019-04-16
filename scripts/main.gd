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
		
		
func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_N:
			if not event.pressed:
				print("pressed N")
				var gt = gui_tip.instance()
				gui_left_elements.add_child(gt)
				


