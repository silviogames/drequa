extends Tween


func _ready():
	interpolate_method(get_parent(), "tween_move", 0, 1, 0.7, Tween.TRANS_QUAD, Tween.EASE_IN)
	set_active(true)
