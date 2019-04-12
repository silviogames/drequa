extends Node2D

var enemy = load("res://scenes/Enemy.tscn")
var tiles_floor = {}

var godot_ysort = null

var entities = []

enum MODE { IDLE, MOVE  }
var mode = MODE.IDLE

export(float, 0.05,2 , 0.05) var move_time = 1

var player = null

func _ready():
	init_tiles()
	godot_ysort = get_node("/root/Main/Objects")
	print("godot_ysort ", godot_ysort)

func walkable( tx,ty ):
	var cell = $Floor.get_cell( tx, ty )
	if cell == -1:
		return false
	else:
		# will crash if tileset has tile that is not in tiles_floor!
		if cell in tiles_floor:
			var td = tiles_floor[cell]
			return td["walkable"]
		else:
			return false

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
	if mode == MODE.MOVE:
		for ent in entities:
			ent.move(value)
	if mode == MODE.MOVE and value == 1:
		for ent in entities:
			ent.end_move()
		mode = MODE.IDLE

	
func start_move():
	for ent in entities:
		ent.act()
	mode = MODE.MOVE
	$entity_mover.interpolate_method(self, "tween_move", 0,1, move_time, Tween.TRANS_EXPO, Tween.EASE_IN)
	$entity_mover.set_active(true)
	$entity_mover.start()

	
func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_SPACE and not event.pressed:
			#spawning new entity
			var e = enemy.instance()
			e.init(4,3)
			godot_ysort.add_child(e)


