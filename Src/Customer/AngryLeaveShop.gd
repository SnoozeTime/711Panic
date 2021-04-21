extends CustomerState


var shelves_to_break = 1

enum Stage {
	Break,
	Leave
}
var stage = Stage.Break
var shelf = null

func enter(_msg := {}) -> void:
	print("Entering AngryLeaveShop state")
	
	# first, get a random shelf and BREAK IT!
	var shelves = get_tree().get_nodes_in_group("Shelf")
	var idx = randi() % shelves.size()
	var target = shelves[idx].get_node("Pickup1")
	shelf = shelves[idx]
	compute_path(target.global_transform.origin)
	# 

func update(_delta: float) -> void:
	if path_idx == path.size():
		match stage:
			Stage.Break:
				shelf.break_shelf()
				MusicManager.play_sound(MusicManager.SoundType.Break)
				compute_path(owner.exit.global_transform.origin)
				stage = Stage.Leave
			Stage.Leave:
				print("reached exit")
				owner.remove_from_scene()
