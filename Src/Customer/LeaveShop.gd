extends CustomerState


func enter(_msg := {}) -> void:
	print("Entering LeaveShop state")
	compute_path(owner.exit.global_transform.origin)

func update(_delta: float) -> void:
	if path_idx == path.size():
		print("reached exit")
		owner.remove_from_scene()
