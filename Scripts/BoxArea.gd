extends Area2D

@export_range(1, 100) var max_capacity: int
@export var inventory: Dictionary[int, int] = {}
@export var items = 0


func _ready() -> void:
	evaluate_capacity()


func interact(player: RigidBody2D):
	
	if player.carry_id >= 0:
		add_box(player)
	else:
		player.open_storage_ui(inventory)


func add_box(player: RigidBody2D) -> void:
	if items + player.carry_count > max_capacity:
		print("Area is full")
		return
	
	items += player.carry_count
	# If such a box already exists, add to it, otherwise put it in
	if inventory.has(player.carry_id):
		inventory[player.carry_id] += player.carry_count
	else:
		inventory[player.carry_id] = player.carry_count
	
	player.carry_id = -1
	player.carry_count = 0
	player.get_node("Box").hide()


func evaluate_capacity():
	items = 0
	for value in inventory.values():
		items += value
