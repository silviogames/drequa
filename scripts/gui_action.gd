extends MarginContainer

var atlas_action_move = load("res://atlas/action_move.atlastex")
var atlas_action_attack = load("res://atlas/action_attack.atlastex")
const utils_dir = preload("res://scripts/utils_dir.gd")

func _ready():
	pass
	
func pressed_action(dir):
	match dir:
		utils_dir.DIR.UP:
			$action_grid/top.self_modulate = Color(1,0,0,1)
			$action_grid/top/tween.interpolate_method(self, "tween_top", -0.5, 1, 0.3, Tween.TRANS_LINEAR,Tween.EASE_IN)
			$action_grid/top/tween.start()
		utils_dir.DIR.RIGHT:
			$action_grid/right/tween.interpolate_method(self, "tween_right", -0.5, 1, 0.3, Tween.TRANS_LINEAR,Tween.EASE_IN)
			$action_grid/right/tween.start()
		utils_dir.DIR.DOWN:
			$action_grid/down/tween.interpolate_method(self, "tween_down", -0.5, 1, 0.3, Tween.TRANS_LINEAR,Tween.EASE_IN)
			$action_grid/down/tween.start()
		utils_dir.DIR.LEFT:
			$action_grid/left/tween.interpolate_method(self, "tween_left", -0.5, 1, 0.3, Tween.TRANS_LINEAR,Tween.EASE_IN)
			$action_grid/left/tween.start()


func tween_top(value):
	$action_grid/top.self_modulate = Color.maroon.linear_interpolate(Color.white, value)

func tween_right(value):
	$action_grid/right.self_modulate = Color.maroon.linear_interpolate(Color.white, value)

func tween_down(value):
	$action_grid/down.self_modulate = Color.maroon.linear_interpolate(Color.white, value)

func tween_left(value):
	$action_grid/left.self_modulate = Color.maroon.linear_interpolate(Color.white, value)
