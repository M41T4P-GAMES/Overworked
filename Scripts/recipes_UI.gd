extends Control

var materialsAndProducts = null
var craftableProducts = []

func _ready() -> void:
	load_materials_and_products()

func load_materials_and_products():
	materialsAndProducts = load("res://Scripts/materials_and_products.gd").new()
	
