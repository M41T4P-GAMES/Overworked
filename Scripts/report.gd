extends CanvasLayer

func _ready() -> void:
	if !is_multiplayer_authority():
		$Panel/Continue.hide()

@rpc("any_peer", "call_local", "reliable")
func show_report():
	show()
	for player in get_tree().get_nodes_in_group("Player"):
		if player.is_multiplayer_authority():
			player.get_node("PickupRange").monitoring = false
			player.get_node("PickupRange").monitorable = false

@rpc("any_peer", "call_local", "reliable")
func hide_report():
	hide()
	for player in get_tree().get_nodes_in_group("Player"):
		if player.is_multiplayer_authority():
			player.get_node("PickupRange").monitoring = true
			player.get_node("PickupRange").monitorable = true

func _on_continue_pressed() -> void:
	if is_multiplayer_authority():
		hide_report.rpc()
		get_node("../HUD/Timer").start()
