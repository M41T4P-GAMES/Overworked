extends CharacterBody2D

const SPEED = 300


func _physics_process(delta: float) -> void:
	var input := Input.get_vector("left", "right", "up", "down")
	
	print(input)
	velocity.x = input.x * SPEED
	velocity.y = input.y * SPEED
	
	move_and_slide()
