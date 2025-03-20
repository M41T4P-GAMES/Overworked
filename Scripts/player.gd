extends RigidBody2D

const SPEED = 65
const MAX_SPEED = 400
var selected_area = null


func _ready() -> void:
	set_multiplayer_authority(int(name))
	if multiplayer.get_unique_id() == int(name):
		$Camera2D.enabled = true

func _input(event: InputEvent) -> void:
	if is_multiplayer_authority():
		if event.is_action_pressed("interact") and selected_area != null:
			selected_area.interact($Box)


func _physics_process(_delta: float) -> void:
	if is_multiplayer_authority():
		var input := Input.get_vector("left", "right", "up", "down")
		
		if input != Vector2.ZERO:
			linear_velocity.x = move_toward(linear_velocity.x, input.x * MAX_SPEED, SPEED)
			linear_velocity.y = move_toward(linear_velocity.y, input.y * MAX_SPEED, SPEED)
		else:
			linear_velocity.x = move_toward(linear_velocity.x, 0, SPEED)
			linear_velocity.y = move_toward(linear_velocity.y, 0, SPEED)



func _on_pickup_range_area_entered(area: Area2D) -> void:
	if is_multiplayer_authority():
		selected_area = area

func _on_pickup_range_area_exited(area: Area2D) -> void:
	if is_multiplayer_authority():
		selected_area = null
