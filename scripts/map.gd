extends Node2D


var tiles_floor = []


func _ready():
	init_tiles()

func walkable( tx,ty ):
	var cell = $Floor.get_cell( tx, ty )
	if cell == -1:
		return false
	else:
		# will crash if tileset has tile that is not in tiles_floor!
		var td = tiles_floor[cell]
		return td["walkable"]

func init_tiles():
	# set values for all tiles
	# id should be same as tileset id
	tiles_floor.append( create_tile_dict( "brick_1", false) )
	tiles_floor.append( create_tile_dict( "brick_2", true) )
	

func create_tile_dict(name : String, walkable : bool):
	var td = {}
	td["name"] = name
	td["walkable"] = walkable
	return td
