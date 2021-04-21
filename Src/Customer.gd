extends KinematicBody

signal stopped_fetching()
signal fetched_item()
signal left_shop()

var target

var velocity: Vector3 = Vector3.ZERO
export(float, 1, 50) var speed = 4
const GRAVITY = 10.0

# Where the customer can go.
var navigation: Navigation

# What the customer needs.
export(Array, ItemGlobals.CrateType) var items_to_fetch

# At what point does the customer gets annoyed if it cannot find its item
export(float, 5, 50) var max_waiting_time = 20.0
var tries_before_giveup = 4.0

var customer_id = -1

var current_state = "EnterShop"

# Where is the shop exit
var exit: Spatial
var entrance: Spatial

var current_shelf = null


# ARCHETYPES !
func set_obasan():
	MusicManager.play_sound(MusicManager.SoundType.Obasan)
	$obasan.show()
	$BigBoyCharacter.hide()
	$RandomCharacter.hide()
	max_waiting_time = 25.0
	tries_before_giveup  = 6.0
	speed = 2.0

func set_bigboy():
	MusicManager.play_sound(MusicManager.SoundType.Angry)
	$obasan.hide()
	$BigBoyCharacter.show()
	$RandomCharacter.hide()
	max_waiting_time = 6.0
	tries_before_giveup = 4.0
	speed = 5.0
	
func set_random():
	MusicManager.play_sound(MusicManager.SoundType.Random)
	$obasan.hide()
	$BigBoyCharacter.hide()
	tries_before_giveup = 5.0
	speed = 3.0
	$RandomCharacter.show()

func _physics_process(_delta):
	velocity.y -= GRAVITY
	velocity = move_and_slide(velocity, Vector3.UP)


func remove_from_scene():
	emit_signal("left_shop", self)


func _on_StateMachine_transitioned(state_name):
	print("%s => %s" % [current_state, state_name])
	current_state = state_name
