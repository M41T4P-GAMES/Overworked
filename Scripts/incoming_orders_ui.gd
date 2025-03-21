extends Control

var leftContainer = null

func _ready():
	leftContainer = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer
	for order in GameStats.currentOrders:
		
