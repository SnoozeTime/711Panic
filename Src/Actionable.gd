extends Node

signal action_from_player()
signal action_released()

var player_in_area: bool = false

func on_action(player):
	emit_signal("action_from_player", player)
	
func on_action_released():
	emit_signal("action_released")
