extends Spatial


func _on_Actionable_action_from_player(player):
	if is_available() && player.has_item():
		var item = player.pop_item()
		$Top.add_child(item)
		item.global_transform.origin = $Top.global_transform.origin
	elif not is_available() and player.can_pick_up():
		var item = remove_item()
		player.take_item(item)

func remove_item():
	var item = $Top.get_child(0)
	$Top.remove_child(item)
	return item

func is_available() -> bool:
	return $Top.get_child_count() == 0
	
func has_item(item_type) -> bool:
	return not is_available() and $Top.get_child(0).item_type == item_type

func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		$Actionable.player_in_area = true

func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		$Actionable.player_in_area = false
