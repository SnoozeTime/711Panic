extends Spatial


onready var hair_styles = $Hair.get_child_count() + 1 # +1 because of bald !
onready var hair_mat = $Hair/Hair1.get_surface_material(0)

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

var current_skin_idx = 0
var current_hair_idx = 0
var current_hair_style_idx = 0

func _ready():
	set_hair(PlayerDefault.hair_style_idx)
	set_skin_color(PlayerDefault.skin_color_idx)
	set_hair_color(PlayerDefault.hair_color_idx)

func set_skin_color(idx):
	$Head.get_surface_material(0).albedo_color = Color(SKIN_PALETTE[idx])
	current_skin_idx = idx
	
func set_hair_color(color_idx):
	hair_mat.albedo_color = Color(HAIR_PALETTE[color_idx % (HAIR_PALETTE.size())])
	current_hair_idx = color_idx % (HAIR_PALETTE.size())

func set_hair(idx):
	if idx < $Hair.get_child_count():
		for i in ($Hair.get_child_count()):
			if i == idx:
				$Hair.get_child(i).show()
			else:
				$Hair.get_child(i).hide()
	else:
		for c in $Hair.get_children():
			c.hide()

	current_hair_style_idx = idx % (hair_styles+1)
