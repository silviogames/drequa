extends Node2D

var utils = preload("res://scripts/utils.gd")
var enemy = load("res://scenes/Enemy.tscn")
var furniture_block = load("res://scenes/Furniture_Block.tscn")
var utils_dir = preload("res://scripts/utils_dir.gd")

var player_class = load("res://scenes/Player.tscn")
var tiles_floor = {}

var godot_ysort = null

var entities = []

var attacks = [] # array of dicts

enum MODE { IDLE, ACT  }
var mode = MODE.IDLE

export(float, 0.05,2 , 0.05) var move_time = 1
export(int) var player_spawn_x = 1
export(int) var player_spawn_y = 1

var player = null

func _ready():
	init_tiles()
	godot_ysort = get_node("/root/Main/Objects")
	player = player_class.instance()
	add_entity(player)
	player.connect_ui()
	player.init([player_spawn_x,player_spawn_y])
	


func is_idle():
	return mode == MODE.IDLE

func walkable( tx,ty ):

	#check floor layer
	var cell = $Floor.get_cell( tx, ty )
	if cell == -1:
		return false
	else:
		# will crash if tileset has tile that is not in tiles_floor!
		if cell in tiles_floor:
			var td = tiles_floor[cell]
			if not td["walkable"]:
				return false
		else:
			return false
	
	#check entity layer:
	# if entity has target pos, current pos is free in next step.
	for e in entities:
		if e.target_pos == null:
			if e.pos[0] == tx and e.pos[1] == ty:
				return false

		else:
			if e.target_pos[0] == tx and e.target_pos[1] == ty:
				return false

	return true

func init_tiles():
	# set values for all tiles
	# id should be same as tileset id
	tiles_floor[0] = create_tile_dict( "brick_1", false) 
	tiles_floor[1] =  create_tile_dict( "brick_2", true) 
	

func create_tile_dict(name : String, walkable : bool):
	var td = {}
	td["name"] = name
	td["walkable"] = walkable
	return td


func tween_move(value):
	if mode == MODE.ACT:
		for ent in entities:
			ent.move(value)
	if mode == MODE.ACT and value == 1:
		for ent in entities:
			ent.end_move()
			
		mode = MODE.IDLE

		for att in attacks:
			print("ATTACK")
			print("attacker: ",att["att"])
			print("victim: ", att["vic"])
			print("pos: ", att["pos"])

			var attacker = att["att"]
			var victim = att["vic"]
			var pos = att["pos"]

			if pos == victim.pos:
				print("victim is at attack position")
				var attack_power = attacker.power()
				print("attack power ", attack_power)
				victim.hit(attack_power)
					
			else:
				print("victim is not at attack position")

		attacks.clear()

	
func start_act():
	for ent in entities:
		ent.act()
	mode = MODE.ACT
	$entity_mover.interpolate_method(self, "tween_move", 0,1, move_time, Tween.TRANS_EXPO, Tween.EASE_IN)
	$entity_mover.set_active(true)
	$entity_mover.start()

func attack_at(pos, attacker, victim):
	# add attack to attack queue which is handled after all entities acted
	var ad = {}
	ad["pos"] = pos
	ad["att"] = attacker
	ad["vic"] = victim

	attacks.append(ad)

	
func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_SPACE and not event.pressed:
			#spawning new entity
			var e = enemy.instance()
			e.init([4,3])
			add_entity(e)
		if event.scancode == KEY_B and not event.pressed:
			#spawning block
			var b = furniture_block.instance()
			b.init([utils.rand_int(1,7),utils.rand_int(1,7)])
			add_entity(b)

func add_entity(entity):
	self.entities.append(entity)
	godot_ysort.add_child(entity)

func find_object(pos):
	# looks for object in entity list at pos
	for e in entities:
		if e.pos == pos:
			return e
	return null

func push_object(pos, dir):
	print("pushing object at ", str(pos))
	print("towards ", utils_dir.dir_name(dir))
	var e  = find_object(pos)
	if e != null:
		print("pushing object ", e.name)
		e.push(dir)

	else:
		print("no object at position")

