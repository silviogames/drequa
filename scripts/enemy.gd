extends Entity

const utils = preload("res://scripts/utils.gd")

var wait_time = 3
var waiting = 3
var walk_target = null

enum TASK { IDLE, FOLLOW, ATTACK}
var current_task = TASK.IDLE

func _ready():
	pass

func init(posx,posy):
	.init(posx, posy)
	max_life = 50
	life = 50

func act():
	
	
	match current_task:
		TASK.IDLE:
			
			var player_dst = utils.dst( self.pos, map.player.pos)
			if player_dst <= globals.ENEMY_VIEW_DST:
				print("player is near, follow!")
				current_task = TASK.FOLLOW
				return
			else:
				if utils.rand_int(0,10) == 10:
					set_target(utils.rand_dir() )

		TASK.FOLLOW:
			if utils.next_to(self.pos, map.player.pos):
				print("player is here, attack!")
				current_task = TASK.ATTACK
				return
			else:
				print("walking to player")
				var dirs = move_to(map.player.pos)
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


		TASK.ATTACK:
			print("attacking player")
			if not utils.next_to(self.pos, map.player.pos):
				print("player is gone")
				current_task = TASK.IDLE
 





		



