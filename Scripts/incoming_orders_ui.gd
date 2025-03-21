extends Control

var leftContainer = null
const incomingOrderPrefab = preload("res://Scenes/incoming_order.tscn")

func _ready():
	leftContainer = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer
	for order in GameStats.currentOrders:
		var currentOrder = incomingOrderPrefab.instantiate()
		leftContainer.add_child(currentOrder)
		currentOrder.display_order(order)
		
		
