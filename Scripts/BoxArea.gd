extends Area2D

@export_range(1, 100) var max_capacity: int
var items = 0


func _ready() -> void:
	evaluate_capacity()


func interact(player: RigidBody2D):
	var boxes = player.get_node("Box")
	
	if boxes.get_child_count() != 0:
		add_box(boxes.get_child(0))
	else:
		player.open_storage_ui($Boxes)


func add_box(new_box: StaticBody2D) -> void:
	print(items+new_box.count)
	print(max_capacity)
	if items+new_box.count > max_capacity:
		print("Area is full")
		return
	
	items += new_box.count
	# If such a box already exists, add to it, otherwise put it in
	for box in $Boxes.get_children():
		if box.item_id == new_box.item_id:
			box.count += new_box.count
			new_box.queue_free()
			return
	
	new_box.reparent($Boxes)
	new_box.hide()


func evaluate_capacity():
	items = 0
	for box in $Boxes.get_children():
		items += box.count
