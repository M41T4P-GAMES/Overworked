extends Control

var recipes = [];
func _ready() -> void:
	parse_recipes()
	
func parse_recipes():
	var file = FileAccess.open("res://recipe)
