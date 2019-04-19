# util class for handling dir stuff


enum DIR { UP, RIGHT, LEFT, DOWN}


static func dir_name(dir):
	match dir:
		DIR.UP:
			return "up"
		DIR.RIGHT:
			return "right"
		DIR.DOWN:
			return "down"
		DIR.LEFT:
			return "left"
		_:
			return "none"

static func dir_to_axis(dir):
	match dir:
		DIR.UP:
			return 1
		DIR.RIGHT:
			return 0
		DIR.DOWN:
			return 1
		DIR.LEFT:
			return 0
		_:
			return 0

static func dir_to_sign(dir):
	match dir:
		DIR.UP:
			return -1
		DIR.RIGHT:
			return 1
		DIR.DOWN:
			return 1
		DIR.LEFT:
			return -1
		_:
			return 0


static func abs_pos(dir, pos):
	# calculate absolute position pos and dir offset

	var dtx = 0
	var dty = 0

	match dir:
		DIR.UP:
			dtx = 0
			dty = -1
		DIR.RIGHT:
			dtx = 1
			dty = 0
		DIR.DOWN:
			dtx = 0
			dty = 1
		DIR.LEFT:
			dtx = -1
			dty = 0
	return [pos[0] + dtx, pos[1] + dty]


static func get_dir(this_pos, other_pos):
	# if other_pos is next to this_pos then return direction to reach that position, else return -1
	var dx = other_pos[0] - this_pos[0]
	var dy = other_pos[1] - this_pos[1]
	if dx == 0 and dy == 0:
		# already at pos
		return -1

	if dx == 0:
		if dy == -1:
			return DIR.UP
		elif dy == 1:
			return DIR.DOWN
		else:
			return -1
	elif dy == 0:
		if dx == -1:
			return DIR.LEFT
		elif dx == 1:
			return DIR.RIGHT
		else:
			return -1
