extends Entity

const utils = preload("res://scripts/utils.gd")

var wait_time = 3
var waiting = 3
var walk_target = null

func _ready():
	pass

func init(posx,posy):
	.init(posx, posy)

func act():
	var player = map.player
	var dirs = move_to(player.pos)
	if dirs == [-1,-1]:
		print("entity is already at target pos")
		return


	for d in dirs:
		if d == -1:
			print("dir not good ",d)
			continue
		else:
			var move_pos = abs_pos(d)
			if map.walkable( move_pos[0], move_pos[1] ):
				print("walking in dir ", d)
				set_target(d)
				return
	print("random movement")

	set_target(utils.rand_dir() )

		



