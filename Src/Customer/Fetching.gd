extends CustomerState


# What the customer needs.
onready var items_to_fetch = owner.items_to_fetch
var current_item_to_fetch = 0

var current_shelf = null
var target = null


func enter(msg := {}) -> void:
	owner.get_node("ComputePathTimer").start()
	
func exit() -> void:
	owner.get_node("ComputePathTimer").stop()

func update(delta: float) -> void:
	
	if current_shelf != null && path.size() == path_idx:
		if current_shelf.has_item(items_to_fetch[current_item_to_fetch]):
			current_shelf.remove_item().queue_free()
			current_item_to_fetch += 1
			
			if current_item_to_fetch == items_to_fetch.size():
				state_machine.transition_to("Paying")
		current_shelf = null

func physics_update(delta: float) -> void:
	var dir = get_direction()

	if dir.x != 0.0 or dir.z != 0.0:
		owner.look_at(owner.global_transform.origin +Vector3(dir.x, 0.0, dir.z), Vector3.UP)
	
	owner.velocity = owner.velocity.linear_interpolate(dir * owner.speed, delta * 10.0)

func _on_ComputePathTimer_timeout():

	# Only look for another shelf when the current shelf is not working out.	
	if current_shelf != null:
		return

	if current_item_to_fetch == items_to_fetch.size():
		return

	for shelf in get_tree().get_nodes_in_group("Shelf"):
		if shelf.has_item(items_to_fetch[current_item_to_fetch]):
			target = shelf.get_node("Pickup1")
			current_shelf = shelf
			break
	
	if target != null:
		compute_path(target.global_transform.origin)
