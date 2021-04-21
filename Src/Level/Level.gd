extends Node

signal shelf_repaired()

export(Array, ItemGlobals.CrateType) var available_items
export(int, 1, 4) var max_item_per_customer = 2

func _ready():
	for shelf in $Navigation/NavigationMeshInstance/Terrain/Shelves.get_children():
		shelf.connect("repaired", self, "on_shelf_repaired")


func get_spawn_position() -> Vector3:
	return $CustomerSpawn.global_transform.origin

func clear_queues() -> void:
	for queue in $Queues.get_children():
		queue.empty()

func setup_customer(customer):
	customer.navigation = $Navigation
	customer.exit = $Exit
	customer.entrance = $Entrance

func on_shelf_repaired():
	emit_signal("shelf_repaired")
