extends Control

var materialsAndProducts = null

func _ready() -> void:
	parse_json()

func parse_json():
	materialsAndProducts = load("res://Scripts/materials_and_products.gd").new()
	
	
