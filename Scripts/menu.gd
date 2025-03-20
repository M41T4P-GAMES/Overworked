extends Control
var PORT = 1234
var udp : PacketPeerUDP
var server_browser_element_scene = preload("res://Scenes/server_browser_element.tscn")
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


func _on_get_servers_pressed() -> void:
	udp = PacketPeerUDP.new()
	udp.bind(1236)
	$browser_timer.start()
	_on_browser_timer_timeout()
	$ServerBrowser.show()


func _on_browser_timer_timeout() -> void:
	if udp.get_available_packet_count() > 1:
		for child in $ServerBrowser/ScrollContainer/VBoxContainer.get_children():
			child.queue_free()
		var node = server_browser_element_scene.instantiate()
		node.ip = udp.get_packet_ip()
		node.player_count = JSON.parse_string(udp.get_packet().get_string_from_ascii()).players
		if node.ip != '' and node.player_count != null:
			node.on_clicked.connect(_on_server_browser_button_pressed)
			$ServerBrowser/ScrollContainer/VBoxContainer.add_child(node)

func _on_server_browser_button_pressed(ip):
	$ip.text = ip
	_on_join_pressed()
