extends MeshInstance

export(ItemGlobals.CrateType) var crate_type


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		$Actionable.player_in_area = true


func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		$Actionable.player_in_area = false


func _on_Actionable_action_from_player(player):
	player.pickup_item(crate_type)
