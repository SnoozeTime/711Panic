# State when the customer will be removed from the scene at the end of the game
# play some POUF animation.
extends CustomerState


func update(_delta: float) -> void:
	owner.remove_from_scene()
