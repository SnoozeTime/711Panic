extends KinematicBody


var meat_item_scene = preload("res://Src/MeatItem.tscn")
var ramen_item_scene = preload("res://Src/RamenItem.tscn")

var velocity: Vector3 = Vector3.ZERO
export(float, 1, 50) var speed = 10.0
const GRAVITY = 10.0


var current_actionable = null

func _process(delta):
	
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
	
	velocity = velocity.linear_interpolate(dir * speed, delta * 10.0)
	velocity = move_and_slide(velocity, Vector3.UP)

func pickup_item(item_type) -> void:
	if can_pick_up():
		var item = get_item_scene(item_type).instance()
		take_item(item)
		
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
