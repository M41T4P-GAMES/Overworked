extends Area2D

@export var taken := false

@rpc("any_peer", "call_local", "reliable")
func interact(player_name: String) -> void:
	if is_multiplayer_authority():
		var player = get_node("../" + player_name)
		if !taken and player.carry_id >= 0 and player.carry_addr.is_empty():
			player.open_stamping.rpc()
			taken = true

@rpc("any_peer", "call_local", "reliable")
func untake():
	if is_multiplayer_authority():
		taken = false
