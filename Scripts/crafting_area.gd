extends Area2D

@export var taken := false

func interact(player: RigidBody2D) -> void:
	if !taken and player.carry_id == -1:
		player.open_crafting()
		taken = true
