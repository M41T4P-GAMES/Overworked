extends Control

var leftContainer = null
const incomingOrderPrefab = preload("res://Scenes/incoming_order.tscn")

func _ready():
	refresh()

func refresh():
	leftContainer = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer
	for child in leftContainer.get_children():
		leftContainer.remove_child(child)
		child.queue_free()
	for order in GameStats.availableOrders:
		var currentOrder = incomingOrderPrefab.instantiate()
		leftContainer.add_child(currentOrder)
		#$MarginContainer/HBoxContainer/Button.order = order
		currentOrder.display_order(order, $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer2)
