extends Area2D
func interact(player: RigidBody2D):
	show_computer.rpc_id(int(player.name))

@rpc("any_peer", "call_local", "reliable")
func show_computer():
	get_node("../ComputerUI").show()
