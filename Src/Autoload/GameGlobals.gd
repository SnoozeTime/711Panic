extends Node

var tutorials_enabled = true
var selected_level = 1
var levels = [
	"res://Src/Level/Level1.tscn",
	"res://Src/Level/Level2.tscn",
	"res://Src/Level/Level3.tscn",
	"res://Src/Level/Level4.tscn",
]

func is_last_level():
	return selected_level == levels.size()

var level_config = [
	{
		"medals": {
			"bronze": 100,
			"silver": 200,
			"gold": 300
		},
		"duration": 80,
		"spawn_interval": 15
	},
	{
		"medals": {
			"bronze": 200,
			"silver": 400,
			"gold": 850
		},
		"duration": 120,
		"spawn_interval": 15
	},
	{
		"medals": {
			"bronze": 600,
			"silver": 800,
			"gold": 1000
		},
		"duration": 120,
		"spawn_interval": 10
	},
	{
		"medals": {
			"bronze": 700,
			"silver": 1000,
			"gold": 1500
		},
		"duration": 180,
		"spawn_interval": 10
	},
]

# levels nb starts with 1.
func select_level(i: int) -> void:
	selected_level = (i-1) % levels.size()

func get_level_path() -> String:
	return levels[selected_level]

func get_level_duration() -> int:
	return level_config[selected_level]["duration"]
	
func get_level_spawn_interval() -> int:
	return level_config[selected_level]["spawn_interval"]
	
func get_medal(level, score) -> String:
	var medals = level_config[level]["medals"]
	if score > medals["gold"]:
		return "gold"
	elif score > medals["silver"]:
		return "silver"
	elif score > medals["bronze"]:
		return "bronze"
	else:
		return ""

