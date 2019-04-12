extends Node2D

func _ready():
	OS.center_window()
	pass
	
func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
