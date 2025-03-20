extends Node2D
var player_scene = preload("res://Scenes/player.tscn")

func _ready() -> void:
	multiplayer.server_disconnected.connect(_on_server_disconnected)
	if multiplayer.is_server():
		multiplayer.peer_connected.connect(_on_peer_connected)
		multiplayer.peer_disconnected.connect(_on_peer_disconnected)
		_on_peer_connected()

func _on_peer_connected(id = 1):
	var node = player_scene.instantiate()
	node.name = str(id)
	add_child(node)
	
func _on_peer_disconnected(id):
	get_node(str(id)).queue_free()

func _on_server_disconnected():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
