extends Node2D

var selected_max_count = 0
var current_count = 1
var selected_id = -1
var boxes: Node2D

var new_box = preload("res://Scenes/box.tscn")


func select(id, count, texture):
	$BottomButtons.show()
	$BottomButtons/Icon.set_texture(texture)
	selected_max_count = count
	current_count = 1
	selected_id = id
	handle_enabling()


func handle_enabling():
	if current_count == selected_max_count:
		$BottomButtons/Add.disabled = true
	else:
		$BottomButtons/Add.disabled = false
	
	if current_count == 1:
		$BottomButtons/Sub.disabled = true
	else:
		$BottomButtons/Sub.disabled = false
	
	$BottomButtons/Count.text = str(current_count)


func update_boxes(box: Node2D) -> void:
	boxes = box


func _on_sub_pressed() -> void:
	current_count -= 1
	handle_enabling()

func _on_add_pressed() -> void:
	current_count += 1
	handle_enabling()


func _on_get_pressed() -> void:
	var box = boxes.get_child(selected_id)
	

	var node = new_box.instantiate()
	node.init(box.item_id, current_count, box.uname, box.get_node("ItemSprite").texture)
	get_node("../../Box").add_child(node)
	node.position = Vector2(0, -100)
	node.show()
	
	box.count -= current_count
	if box.count == 0:
		box.queue_free()
	
	get_node("../../").close_storage_ui()
