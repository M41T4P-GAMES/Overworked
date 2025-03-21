extends Node2D

var selected_max_count = 0
var current_count = 1
var selected_id = -1
var inventory: Dictionary

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


func update_inv(inv: Dictionary) -> void:
	inventory = inv


func _on_sub_pressed() -> void:
	current_count -= 1
	handle_enabling()

func _on_add_pressed() -> void:
	current_count += 1
	handle_enabling()


func _on_get_pressed() -> void:
	var entry: Dictionary = Global.get_entry_by_id("res://Assets/Data/materials_and_products.json", selected_id)
	
	var player = get_node("../../")
	player.carry_id = selected_id
	player.carry_count = current_count
	player.get_node("Box/ItemSprite").set_texture(load(entry["sprite"]))
	player.get_node("Box").show()
	
	inventory[selected_id] -= current_count
	if inventory[selected_id] == 0:
		inventory.erase(selected_id)
	
	player.close_storage_ui()
