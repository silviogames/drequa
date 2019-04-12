# utility methods that work without node


static func rand_int(start, end):
	if start > end:
		return start
	return start + (randi() % (end - start + 1))

static func rand_dir():
	var r = randi() % 4
	return r

static func dst(pos1, pos2):
	return int( sqrt( pow( abs( pos1[0] - pos2[0]), 2) + pow( abs( pos1[1] - pos2[1]), 2)))

static func next_to(pos1, pos2):
	# return true if pos1 is adjacent to pos2, not diagonally

	var dx = abs(pos1[0] - pos2[0])
	var dy = abs(pos1[1] - pos2[1])

	if dx == 1 and dy == 0:
		return true
	elif dx == 0  and dy == 1:
		return true
	else:
		return false



