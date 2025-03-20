extends Area2D

@export_range(1, 100) var max_capacity: int
var boxes = 2


func interact(boxes: Node2D):
	if boxes.get_child_count() != 0:
		add_box(boxes.get_child(0))
	else:
		get_box(boxes)


func add_box(box: StaticBody2D) -> void:
	if boxes+1 > max_capacity:
		print("Area is full")
		return
	
	boxes += 1
	box.reparent($Boxes)
	box.position = Vector2.ZERO


func get_box(box: Node2D) -> void:
	if boxes-1 < 0:
		print("Nothing to pick up")
		return
	
	boxes -= 1
	var box_to_go: StaticBody2D = $Boxes.get_child(0)
	box_to_go.reparent(box)
	box_to_go.position = Vector2(0, -100)
