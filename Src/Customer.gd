extends KinematicBody

var target

var velocity: Vector3 = Vector3.ZERO
export(float, 1, 50) var speed = 2.0
const GRAVITY = 10.0

# Where the customer can go.
var navigation: Navigation

# What the customer needs.
export(Array, ItemGlobals.CrateType) var items_to_fetch

# Where is the shop exit
var exit: Spatial

var current_shelf = null


func _physics_process(delta):

	velocity.y -= GRAVITY
	velocity = move_and_slide(velocity, Vector3.UP)
