extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const BODY_PALETTE = [
	"46425e",
	"15788c",
	"00b9be",
	"ffeecc",
	"ffb0a3",
	"ff6973"
]
const SKIN_PALETTE = [
	"c58c85",
	"ecbcb4",
	"d1a3a4",
	"a1665e",
	"503335",
	"592f2a"
]

const HAIR_PALETTE  = [
	"2b0f54",
	"ab1f65",
	"ff4f69",
	"fff7f8",
	"ff8142",
	"ffda45",
	"3368dc",
	"49e7ec",
]


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	var hair_idx = randi() % ($Hair.get_child_count() + 1)
	for i in range($Hair.get_child_count()):
		if i == hair_idx:
			$Hair.get_child(i).show()
		else:
			$Hair.get_child(i).hide()
			
	
	var hair_color = randi() % HAIR_PALETTE.size()
	$Hair/Hair1.get_surface_material(0).albedo_color = Color(HAIR_PALETTE[hair_color])
	#set_hair_color(hair_color)
	var skin_color = randi() % SKIN_PALETTE.size()
	$Head.get_surface_material(0).albedo_color = Color(SKIN_PALETTE[skin_color])

	var body_color = BODY_PALETTE[randi() % BODY_PALETTE.size()]
	print("Will use %s for body" % body_color)
	$Body.get_surface_material(0).albedo_color = Color(body_color)
