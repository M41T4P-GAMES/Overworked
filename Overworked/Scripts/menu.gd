extends Control
var PORT = 1234
var udp : PacketPeerUDP
var server_browser_element_scene = preload("res://Scenes/server_browser_element.tscn")
var peer = ENetMultiplayerPeer.new()

var will_host = false
var ip = ''

func _ready() -> void:
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	GameStats.reset()

func _on_host_pressed() -> void:
	will_host = true
	$SkinChange.enabled = true

func _on_join_pressed() -> void:
	will_host = false
	ip = $ip.text
	$SkinChange.enabled = true

func _on_connected_to_server():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func host():
	peer.create_server(PORT, 3)
	multiplayer.multiplayer_peer = peer
	_on_connected_to_server()

func join():
	if ip == '':
		ip = "localhost"
	peer.create_client(ip, PORT)
	multiplayer.multiplayer_peer = peer


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
	ip = ip
	will_host = false
	$SkinChange.enabled = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		$ServerBrowser.hide()


func _on_join_server_pressed() -> void:
	if will_host:
		host()
	else:
		join()


func _on_back_pressed() -> void:
	$SkinChange.enabled = false


func _on_quit_pressed() -> void:
	get_tree().quit()
