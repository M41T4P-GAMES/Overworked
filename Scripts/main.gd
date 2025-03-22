extends Node2D
var player_scene = preload("res://Scenes/player.tscn")
var orderGeneration = null

func _ready() -> void:
	orderGeneration = load("res://Scripts/order_generation.gd").new()
	orderGeneration.parse_json()
	multiplayer.server_disconnected.connect(_on_server_disconnected)
	if multiplayer.is_server():
		multiplayer.peer_connected.connect(_on_peer_connected)
		multiplayer.peer_disconnected.connect(_on_peer_disconnected)
		_on_peer_connected()
	

func _on_peer_connected(id = 1):
	var node = player_scene.instantiate()
	node.name = str(id)
	#node.global_position = $Spawnpoint.global_position
	add_child(node)
	
func _on_peer_disconnected(id):
	get_node(str(id)).queue_free()

func _on_server_disconnected():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func send_udp():
	if multiplayer.is_server():
		var udp = PacketPeerUDP.new()
		udp.bind(1235)
		udp.set_broadcast_enabled(true)
		udp.set_dest_address("255.255.255.255", 1236)
		var info = {"players": multiplayer.get_peers().size() + 1}
		var text = JSON.stringify(info)
		var bytes = text.to_ascii_buffer()
		udp.put_packet(bytes)

func _on_udp_timer_timeout() -> void:
	send_udp()
#
func _on_order_generation_timer_timeout() -> void:
	if GameStats.availableOrders.size() < 5:
		GameStats.availableOrders.append(orderGeneration.generate_random_order())
		#$Control2.refresh()
	$OrderGenerationTimer.start(randi_range(5, 15))
