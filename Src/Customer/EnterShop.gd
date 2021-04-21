extends CustomerState


var moving = false


func update(_delta: float) -> void:

	if moving && path_idx == path.size():
		state_machine.transition_to("Fetching")
	elif moving == false:
		if owner.entrance != null:
			compute_path(owner.entrance.global_transform.origin)
			moving = true
