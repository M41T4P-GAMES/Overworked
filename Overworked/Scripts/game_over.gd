extends Node2D


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func _ready() -> void:
	multiplayer.multiplayer_peer = null
	$Money.text = "$" + str(GameStats.money)
