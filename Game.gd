extends Spatial

var customer_id_counter = 0

var customer_scene = preload("res://Src/Customer.tscn")

var total_points = 0
var seconds_before_start = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicManager.play_level()
	
	# Load the level first.
	var level = load(GameGlobals.get_level_path()).instance()
	level.name = "Level"
	level.connect("shelf_repaired", self, "on_shelf_repaired")
	add_child(level)
	move_child(level, 0)
	
	for customer in $Customers.get_children():
		setup_customer(customer)
		
	for cashier in get_tree().get_nodes_in_group("Cashier"):
		cashier.connect("paid", self, "on_customer_paid")

func on_shelf_repaired():
	total_points += 25
	$HUD.update_points(total_points)

func on_customer_stopped_fetching(customer):
	$HUD/CustomerGUI.remove_customer(customer.customer_id)

func on_customer_paid():
	total_points += 100 # as opposed to angry leave. :D
	$HUD.update_points(total_points)

func on_customer_leave(customer):
	customer.call_deferred("queue_free")

func on_item_fetched(customer, item_id):
	$HUD/CustomerGUI.set_fetched(customer.customer_id, item_id)

func _process(_delta):
	var seconds = $GameTimer.time_left

	var minutes = floor(seconds / 60)
	var seconds_left = int(seconds - 60 * minutes)
	$HUD.update_game_timer(minutes, seconds_left)
	
	
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = true
		$PauseScene.pause()

func setup_customer(customer):
	$Level.setup_customer(customer)
	customer.customer_id = customer_id_counter
	customer.connect("stopped_fetching", self, "on_customer_stopped_fetching")
	customer.connect("left_shop", self, "on_customer_leave")
	customer.connect("fetched_item", self, "on_item_fetched")
	customer_id_counter += 1
	$HUD/CustomerGUI.add_customer(customer)

func _on_SpawnTimer_timeout():
	spawn_customer()
	
func spawn_customer():
	var customer = customer_scene.instance()
	var char_type = randi() % 3
	if char_type == 0:
		customer.set_obasan()
	elif char_type == 1:
		customer.set_bigboy() 
	else:
		customer.set_random()
	
	# What to fetch.
	var available_items = $Level.available_items
	var count = (randi() % $Level.max_item_per_customer) + 1
	var items_to_fetch = []
	for _i in range(count):
		var item_type = randi() % available_items.size()
		items_to_fetch.append(available_items[item_type])
	customer.items_to_fetch = items_to_fetch
	
	$Customers.add_child(customer)
	
	customer.global_transform.origin = $Level.get_spawn_position()
	setup_customer(customer)	

func start_game():
	$StartGameTimer.stop()
	$GameTimer.start(GameGlobals.get_level_duration())
	$SpawnTimer.start(GameGlobals.get_level_spawn_interval())
	spawn_customer()
	$HUD/TimerLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$HUD.set_message("")

func _on_GameTimer_timeout():
	gameover()

func gameover():
	SavedData.set_score(GameGlobals.selected_level, total_points)
	for c in $Customers.get_children():
		c.get_node("StateMachine").transition_to("Disappear")
	
	$Level.clear_queues()
	
	$HUD.set_message("Time out!")
	$SpawnTimer.stop()
	$HUD.clear_customers()
	
	yield(get_tree().create_timer(1.5), "timeout")
	$GameOverPanel.show_game_over(total_points)

func _on_StartGameTimer_timeout():
	
	seconds_before_start -= 1
	
	match seconds_before_start:
		2:
			$HUD.set_message("Ready")
		1:
			$HUD.set_message("Steady")
		0:
			$HUD.set_message("Go!")
	if seconds_before_start == 0:
		start_game()
