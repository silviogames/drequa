extends Entity


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

func power():
	return 5

func act():
	
	
	match current_task:
		TASK.IDLE:
			task_idle()
		TASK.FOLLOW:
			task_follow()
		TASK.ATTACK:
			task_attack()

func task_idle():
	var player_dst = utils.dst( self.pos, map.player.pos)
	if player_dst <= globals.ENEMY_VIEW_DST:
		print("player is near, follow!")
		current_task = TASK.FOLLOW
		task_follow()
		return
	else:
		if utils.rand_int(0,10) == 10:
			set_target(utils.rand_dir() )
 
func task_follow():
	if utils.next_to(self.pos, map.player.get_next_pos()):
		print("player is here, attack!")
		task_attack()
		current_task = TASK.ATTACK
		return
	else:
		print("walking to player")
		var dirs = move_to(map.player.get_next_pos())
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


func task_attack():
	print("attacking player")
	if not utils.next_to(self.pos, map.player.get_next_pos()):
		print("player is gone")
		task_idle()
		current_task = TASK.IDLE
		attack_dir = null
		attack_target = null
	else:
		var player_dir = get_dir(map.player.get_next_pos())
		print("player is " + dir_name(player_dir))
		if player_dir != -1:
			attack_target = map.player
			attack_dir = player_dir


