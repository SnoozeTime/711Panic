extends Spatial


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		$Actionable.player_in_area = true


func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		$Actionable.player_in_area = false


func _on_Actionable_action_from_player(player):
	if player.has_item():
		var item = player.pop_item()
		item.queue_free()
