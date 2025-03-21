extends Area2D

@export_range(1, 100) var max_capacity: int
@export var inventory: Dictionary[int, int] = {}
@export var items = 0


func _ready() -> void:
	evaluate_capacity()


func interact(player: RigidBody2D):
	var boxes = player.get_node("Box")
	
	if boxes.get_child_count() != 0:
		add_box(boxes.get_child(0))
	else:
		player.open_storage_ui(inventory)


func add_box(new_box: StaticBody2D) -> void:
	if items+new_box.count > max_capacity:
		print("Area is full")
		return
	
	items += new_box.count
	# If such a box already exists, add to it, otherwise put it in
	if inventory.has(new_box.item_id):
		inventory[new_box.item_id] += new_box.count
	else:
		inventory[new_box.item_id] = new_box.count
	
	new_box.queue_free()


func evaluate_capacity():
	items = 0
	for value in inventory.values():
		items += value
