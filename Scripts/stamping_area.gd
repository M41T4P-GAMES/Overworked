extends Area2D

@export var taken := false


func interact(player: RigidBody2D) -> void:
	#if player.carry_id >= 0:
		#taken = true
		#player.open_stamping()
	if !taken:
		player.open_stamping()
		taken = true
