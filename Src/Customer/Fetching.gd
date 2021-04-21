extends CustomerState


# What the customer needs.
onready var items_to_fetch = owner.items_to_fetch
var current_item_to_fetch = 0

var current_shelf = null
var target = null

var tries = -1


func enter(_msg := {}) -> void:
	owner.get_node("ComputePathTimer").start()
	
func exit() -> void:
	owner.get_node("ComputePathTimer").stop()
	owner.emit_signal("stopped_fetching", owner)

func update(delta: float) -> void:

	if current_shelf != null && path.size() == path_idx:
		if current_shelf.has_item(items_to_fetch[current_item_to_fetch]):
			current_shelf.remove_item().queue_free()
			owner.emit_signal("fetched_item", owner, current_item_to_fetch)
			current_item_to_fetch += 1
			tries = 0
			
			if current_item_to_fetch == items_to_fetch.size():
				state_machine.transition_to("Paying")
		current_shelf = null
	elif path.size() == path_idx:
		# No target, but still, it's nice to go somewhere.
		go_to_random_shelf()
		tries += 1
		print("Tries %s/%s" % [tries, owner.tries_before_giveup])
		if tries >= owner.tries_before_giveup:
			state_machine.transition_to("AngryLeaveShop")

func go_to_random_shelf():
	var shelves = get_tree().get_nodes_in_group("Shelf")
	if shelves.size() > 0:
		var idx = randi() % shelves.size()
		target = shelves[idx].get_node("Pickup1")
		compute_path(target.global_transform.origin)

func _on_ComputePathTimer_timeout():

	# Only look for another shelf when the current shelf is not working out.	
	if current_shelf != null:
		return

	for shelf in get_tree().get_nodes_in_group("Shelf"):
		if shelf.has_item(items_to_fetch[current_item_to_fetch]):
			target = shelf.get_node("Pickup1")
			current_shelf = shelf
			break
	
	if target != null:
		compute_path(target.global_transform.origin)
