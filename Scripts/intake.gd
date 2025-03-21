extends Area2D

@export_range(1, 100) var max_capacity: int
@export var inventory: Dictionary[int, int] = {}
@export var items = 0


func _ready() -> void:
	evaluate_capacity()


func interact(player: RigidBody2D):
	if !player.carry_addr.is_empty():
		if player.carry_id < 0:
			open_storage_ui_rpc.rpc(player.name, inventory)

@rpc("any_peer", "call_local", "reliable")
func open_storage_ui_rpc(player_name, inventory):
	get_node("../" + player_name).open_storage_ui(inventory)


func remove_item(player: RigidBody2D, id: int, count: int) -> void:
	inventory[id] -= count
	if inventory[id] == 0:
		inventory.erase(id)
	
	items -= count
	player.set_carry_id(id)
	player.set_carry_count(count)
	
	if items <= 0:
		get_node("../AnimationPlayer").play("take_off")


func evaluate_capacity():
	items = 0
	for value in inventory.values():
		items += value
