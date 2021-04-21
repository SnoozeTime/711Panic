extends MarginContainer

var customer_panel_scene = preload("res://Src/GUI/CustomerPanel.tscn")

func add_customer(customer) -> void:
	var panel = customer_panel_scene.instance()
	panel.customer_id = customer.customer_id
	$CustomerPanels.add_child(panel)
	panel.populate(customer.items_to_fetch)

func remove_customer(customer_id) -> void:
	var to_remove = null
	
	for panel in $CustomerPanels.get_children():
		if panel.customer_id == customer_id:
			to_remove = panel
			break
			
	if to_remove != null:
		$CustomerPanels.remove_child(to_remove)

func clear():
	for c in $CustomerPanels.get_children():
		$CustomerPanels.remove_child(c)
		c.queue_free()

func set_fetched(customer_id, item_id):
	var customer_panel = null
	
	for panel in $CustomerPanels.get_children():
		if panel.customer_id == customer_id:
			customer_panel = panel
			break
			
	if customer_panel != null:
		customer_panel.set_fetched(item_id)
