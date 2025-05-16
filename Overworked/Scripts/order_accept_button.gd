extends Button

func _on_pressed() -> void:
	var order = get_node("../../../..").currentOrder
	GameStats.acceptedOrders.append(order)
	GameStats.availableOrders.erase(order)
	get_node("../../../..").currentOrder = null
	get_node("../../../../../../../../..").refresh()
	get_node("../../../..").visible = false
