extends Control

var recipes = []

func _ready() -> void:
	parse_json()

func parse_json():
	var file = FileAccess.open("res://recipes.json", FileAccess.READ)
	var text = file.get_as_text()
	recipes = JSON.parse_string(text)
