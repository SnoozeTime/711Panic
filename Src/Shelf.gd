extends Spatial




signal repaired()

# If true, only accepts icecream
export var icecream_shelf = false
# If true, cannot put anything on the shelf until it is fixed.
export var broken = false
var fixing = false
export(float, 1, 5) var time_to_fix = 2.0
var fixing_time = 0

var top


func _ready():
	if icecream_shelf:
		top = $Top2
	else:
		top = $Top
	show_shelf()

	if broken:
		break_shelf()

func _process(delta):
	if fixing and broken:
		fixing_time += delta
		$ProgressBar3D.set_progress(fixing_time, time_to_fix)
		if fixing_time > time_to_fix:
			fix_shelf()
			
func hide_shelf():
	if icecream_shelf:
		$BrokenShelfMesh2.show()
		$IceCreamShelfMesh.hide()
	else:
		$BrokenShelfMesh.show()
		$ShelfMesh.hide()
		
func show_shelf():
	if icecream_shelf:
		$BrokenShelfMesh2.hide()
		$IceCreamShelfMesh.show()
		$ShelfMesh.hide()
	else:
		$BrokenShelfMesh.hide()
		$ShelfMesh.show()
		$IceCreamShelfMesh.hide()
			
func fix_shelf():
	MusicManager.play_sound(MusicManager.SoundType.Repare)
	broken = false
	fixing = false
	show_shelf()
	emit_signal("repaired")
	$ProgressBar3D.hide_progress_bar()
			
func break_shelf():
	broken = true
	if top.get_child_count() == 1:
		# Remove item. So mean !
		var item = remove_item()
		item.queue_free()
	
	hide_shelf()

func _on_Actionable_action_from_player(player):
	
	# First case. Not broken, player has item. Can put item on shelf.
	if not broken:
		if is_available() && player.has_item() && can_accept_item(player.get_current_item_type()):
			var item = player.pop_item()
			MusicManager.play_sound(MusicManager.SoundType.PlaceItem)
			top.add_child(item)
			item.global_transform.origin = top.global_transform.origin
		elif not is_available() and player.can_pick_up():
			MusicManager.play_sound(MusicManager.SoundType.PlaceItem)
			var item = remove_item()
			player.take_item(item)
	else:
		if not player.has_item():
			# In that case, player can fix the shelf.
			fixing = true
			fixing_time = 0
			$ProgressBar3D.show_progress_bar()
			$ProgressBar3D.set_progress(fixing_time, time_to_fix)

func can_accept_item(item_type):
	if icecream_shelf:
		return item_type == ItemGlobals.CrateType.Icecream
	else:
		return item_type != ItemGlobals.CrateType.Icecream 

func remove_item():
	var item = top.get_child(0)
	top.remove_child(item)
	return item

func is_available() -> bool:
	return top.get_child_count() == 0
	
func has_item(item_type) -> bool:
	return not is_available() and top.get_child(0).item_type == item_type

func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		$Actionable.player_in_area = true

func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		$Actionable.player_in_area = false
		fixing = false
		$ProgressBar3D.hide_progress_bar()

func _on_Actionable_action_released():
	fixing = false
	$ProgressBar3D.hide_progress_bar()
