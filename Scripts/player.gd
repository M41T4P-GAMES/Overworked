extends RigidBody2D

const SPEED = 65
const MAX_SPEED = 400
var selected_area = null
var item_tab = preload("res://Scenes/item_tab.tscn")


func _ready() -> void:
	set_multiplayer_authority(int(name))
	if multiplayer.get_unique_id() == int(name):
		$Camera2D.enabled = true
		$Sprite2D.self_modulate = Global.skin_color


func _input(event: InputEvent) -> void:
	if is_multiplayer_authority():
		if event.is_action_pressed("interact") and selected_area != null:
			selected_area.interact(self)


func _physics_process(_delta: float) -> void:
	if is_multiplayer_authority():
		var input := Input.get_vector("left", "right", "up", "down")
		
		if input != Vector2.ZERO:
			linear_velocity.x = move_toward(linear_velocity.x, input.x * MAX_SPEED, SPEED)
			linear_velocity.y = move_toward(linear_velocity.y, input.y * MAX_SPEED, SPEED)
		else:
			linear_velocity.x = move_toward(linear_velocity.x, 0, SPEED)
			linear_velocity.y = move_toward(linear_velocity.y, 0, SPEED)


func open_storage_ui(boxes: Node2D) -> void:
	freeze = true
	$BoxStorage/UI/BottomButtons.hide()
	$BoxStorage.show()
	
	if boxes.get_child_count() == 0:
		return
	
	for box in boxes.get_children():
		var new_item = item_tab.instantiate()
		new_item.init(box.item_id, box.count, box.name, box.get_node("BoxSprite").texture)
		$BoxStorage/UI/ScrollContainer/ItemList.add_child(new_item)
	
	$BoxStorage/UI.update_boxes(boxes)

func close_storage_ui() -> void:
	freeze = false
	$BoxStorage.hide()
	selected_area.evaluate_capacity()
	for i in $BoxStorage/UI/ScrollContainer/ItemList.get_children():
		i.queue_free()


func _on_pickup_range_area_entered(area: Area2D) -> void:
	if is_multiplayer_authority():
		selected_area = area

func _on_pickup_range_area_exited(area: Area2D) -> void:
	if is_multiplayer_authority():
		selected_area = null
