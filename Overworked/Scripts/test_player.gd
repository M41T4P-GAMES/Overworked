extends CharacterBody2D

func _ready() -> void:
	set_multiplayer_authority(int(name))

func _process(delta: float) -> void:
	if is_multiplayer_authority():
		velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * 200
		move_and_slide()
