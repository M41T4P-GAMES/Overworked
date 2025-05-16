extends Button

func _on_pressed() -> void:
	var order = get_node("../../../..").currentOrder
	GameStats.availableOrders.erase(order)
	get_node("../../../..").currentOrder = null
	get_node("../../../..").visible = false
	get_node("../../../../../../../../..").refresh()
