extends Control
var PORT = 1234
var udp : PacketPeerUDP

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
		


func _on_browser_timer_timeout() -> void:
	if udp.get_available_packet_count() > 1:
		print(udp.get_packet_ip())
		print(udp.get_packet().get_string_from_ascii())
