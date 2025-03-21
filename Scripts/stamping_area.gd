extends Area2D

@export var taken := false


func interact(player: RigidBody2D) -> void:
	if !taken and player.carry_id >= 0 and player.carry_addr.is_empty():
		player.open_stamping()
		taken = true
