extends Node2D


class_name Entity


var tx = 0
var ty = 0

func _ready():
	init()
	
	
func init():
	move(5,5)
	


func move(dtx = 0, dty = 0):
	tx += dtx
	ty += dty
	position.x = (tx * 16) + 8
	position.y = (ty * 16) + 8
