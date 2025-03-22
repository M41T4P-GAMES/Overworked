extends Control



func _on_store_pressed():
	open_store.rpc_id(multiplayer.get_unique_id())

@rpc("any_peer", "call_local", "reliable")
func open_store():
	get_node("../Store").show()


func _on_close_pressed() -> void:
	close_store.rpc_id(multiplayer.get_unique_id())

@rpc("any_peer", "call_local", "reliable")
func close_store():
	hide()
