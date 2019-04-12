# utility methods that work without node


static func rand_int(start, end):
	if start > end:
		return start
	return start + (randi() % (end - start + 1))

static func rand_dir():
	var r = randi() % 4
	return r
