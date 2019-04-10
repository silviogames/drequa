extends Node2D

func _ready():
	print("player ready")
	
	
func _process(delta):
	if Input.is_key_pressed(KEY_D):
		position.x += delta * 100
	if Input.is_key_pressed(KEY_A):
		position.x -= delta * 100
	if Input.is_key_pressed(KEY_W):
		position.y -= delta * 100
	if Input.is_key_pressed(KEY_S):
		position.y += delta * 100
		
