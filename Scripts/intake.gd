extends Area2D

@export_range(1, 100) var max_capacity: int
@export var inventory: Dictionary[int, int] = {}
@export var items = 0


func _ready() -> void:
	evaluate_capacity()

@rpc("any_peer", "call_local", "reliable")
func interact(player_name : String):
	if is_multiplayer_authority():
		var player = get_node("../" + player_name)
		if player.carry_id < 0:
			open_storage_ui_rpc.rpc(player.name, inventory)

@rpc("any_peer", "call_local", "reliable")
func open_storage_ui_rpc(player_name, inventory):
	get_node("../" + player_name).open_storage_ui.rpc(inventory)

@rpc("any_peer", "call_local", "reliable")
func remove_item(player_name : String, id: int, count: int) -> void:
	if is_multiplayer_authority():
		var player = get_node("../" + player_name)
		inventory[id] -= count
		if inventory[id] == 0:
			inventory.erase(id)
		
		items -= count
		player.set_carry_id(id)
		player.set_carry_count(count)
		
		if items <= 0:
			get_node("../Tiri/Incoming/AnimationPlayer").play("take_off")


func evaluate_capacity():
	items = 0
	for value in inventory.values():
		items += value

@rpc("any_peer", "call_local", "reliable")
func generate_items():
	if is_multiplayer_authority():
		inventory = {
			0:10,
			1:5
		}
		evaluate_capacity()
