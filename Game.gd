extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for customer in $Customers.get_children():
		customer.navigation = $Navigation
		customer.exit = $Exit
