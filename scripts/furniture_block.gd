extends Furniture

func _ready():
	pass
	
func init(pos):
	super_init(pos, "block", [PROP.PUSH])
