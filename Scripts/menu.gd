extends Control
var PORT = 1234


var peer = ENetMultiplayerPeer.new()

func _ready() -> void:
	multiplayer.connected_to_server.connect(_on_connected_to_server)

func _on_host_pressed() -> void:
	peer.create_server(PORT, 3)
	multiplayer.multiplayer_peer = peer
	_on_connected_to_server()

func _on_join_pressed() -> void:
	var ip = $ip.text
	if ip == '':
		ip = "localhost"
	peer.create_client(ip, PORT)
	multiplayer.multiplayer_peer = peer

func _on_connected_to_server():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
