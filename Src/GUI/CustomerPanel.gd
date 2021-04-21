extends Panel


var meat_icon_scene = preload("res://Src/GUI/MeatIcon.tscn")
var ramen_icon_scene = preload("res://Src/GUI/RamenIcon.tscn")
var water_icon_scene = preload("res://Src/GUI/WaterIcon.tscn")
var icecream_icon_scene = preload("res://Src/GUI/IceCreamIcon.tscn")


var customer_id = -1

func populate(items: Array):
	for item in items:
		match item:
			ItemGlobals.CrateType.Ramen:
				$MarginContainer/Needs/HBoxContainer.add_child(ramen_icon_scene.instance())
			ItemGlobals.CrateType.Meat:
				$MarginContainer/Needs/HBoxContainer.add_child(meat_icon_scene.instance())
			ItemGlobals.CrateType.Water:
				$MarginContainer/Needs/HBoxContainer.add_child(water_icon_scene.instance())
			ItemGlobals.CrateType.Icecream:
				$MarginContainer/Needs/HBoxContainer.add_child(icecream_icon_scene.instance())
				
func set_fetched(idx):
	$MarginContainer/Needs/HBoxContainer.get_child(idx).hide()
