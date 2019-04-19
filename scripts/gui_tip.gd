extends MarginContainer

enum STATUS {COME, STAY, GO}

var status = STATUS.COME
var stay_time = 3
var start_margin_left = -80
var auto_go = true

func _ready():
	set("custom_constants/margin_left", start_margin_left)
	$Tween.interpolate_method(self, "move", start_margin_left, 0, 0.5 ,Tween.TRANS_CUBIC, Tween.EASE_IN)
	$Tween.start()
	
func move(value):
	set("custom_constants/margin_left", int(value))
	
func go():
	if status != STATUS.GO:
		status = STATUS.GO
		$Tween.interpolate_method(self,"move", 0, start_margin_left, 0.5, Tween.TRANS_CUBIC, Tween.EASE_IN)
		$Tween.start()

func _on_Timer_timeout():
	if auto_go:
		go()

func _on_Tween_tween_completed(object, key):
	match status:
		STATUS.COME:
			status = STATUS.STAY
			$Timer.wait_time = stay_time
			$Timer.start()
		STATUS.GO:
			queue_free()
			
func set_message( message):
	$MarginContainer/Label.text = message

