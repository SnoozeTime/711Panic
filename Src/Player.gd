extends KinematicBody


var meat_item_scene = preload("res://Src/MeatItem.tscn")
var ramen_item_scene = preload("res://Src/RamenItem.tscn")
var water_item_scene = preload("res://Src/WaterItem.tscn")
var icecream_item_scene = preload("res://Src/IcecreamItem.tscn")

var velocity: Vector3 = Vector3.ZERO
export(float, 1, 50) var speed = 10.0
const GRAVITY = 10.0

export var boost_str = 15.0

var last_dir = Vector3()


var current_actionable = null

func _process(_delta):
	
	# Manage the action button. Could be various thing. Pickup items. Put items
	# on shelves. Make customer pay, put off fire....
	if Input.is_action_just_pressed("Action"):
		for actionable in get_tree().get_nodes_in_group("Actionable"):
			if actionable.player_in_area:
				actionable.on_action(self)
				current_actionable = actionable
				break

	if Input.is_action_just_released("Action") && current_actionable != null:
		current_actionable.on_action_released()

func _physics_process(delta):
	
	var dir = Vector3.ZERO
	var dir_plane = Vector2.ZERO
	
	dir_plane.y = -Input.get_action_strength("movement_up") + Input.get_action_strength("movement_down")
	dir_plane.x = -Input.get_action_strength("movement_left") + Input.get_action_strength("movement_right")
	dir_plane = dir_plane.clamped(1.0)
	
	
	dir.z = dir_plane.y
	dir.x = dir_plane.x
	
	velocity.y -= GRAVITY
	
	if dir.x != 0.0 or dir.z != 0.0:
		look_at(global_transform.origin +Vector3(dir.x, 0.0, dir.z), Vector3.UP)
		last_dir = dir
	
	if Input.is_action_just_pressed("Boost"):
		
		MusicManager.play_sound(MusicManager.SoundType.Dash)
		velocity.x += last_dir.x * boost_str
		velocity.z += last_dir.z * boost_str
		$ScaleParticle.restart()
		$ScaleParticle.set_emitting(true)
	
	
	velocity = velocity.linear_interpolate(dir * speed, delta * 10.0)
	velocity = move_and_slide(velocity, Vector3.UP)

func pickup_item(item_type) -> void:
	if can_pick_up():
		MusicManager.play_sound(MusicManager.SoundType.PlaceItem)
		var item = get_item_scene(item_type).instance()
		take_item(item)

func get_current_item_type():
	return $Hands.get_child(0).item_type

func take_item(item):
	$Hands.add_child(item)
	item.global_transform.origin = $Hands.global_transform.origin
		
func has_item() -> bool:
	return $Hands.get_child_count() == 1
	
func pop_item() -> Node:
	var item = $Hands.get_child(0)
	$Hands.remove_child(item)
	return item

func can_pick_up() -> bool:
	return $Hands.get_child_count() == 0

func get_item_scene(item_type):
	match item_type:
		ItemGlobals.CrateType.Meat:
			return meat_item_scene
		ItemGlobals.CrateType.Ramen:
			return ramen_item_scene
		ItemGlobals.CrateType.Water:
			return water_item_scene
		ItemGlobals.CrateType.Icecream:
			return icecream_item_scene
			
func show_progress_bar():
	$Billboard.show()
	
func hide_progress_bar():
	$Billboard.hide()

func set_progress(current, max_progress):
	$Viewport/ProgressBar.set_max(max_progress)
	$Viewport/ProgressBar.set_value(current)
