extends Area2D

@export_range(1, 100) var max_capacity: int
@export var inventory: Dictionary[int, int] = {}
@export var cache: Array[Dictionary] = []
@export var items = 0


func _ready() -> void:
	evaluate_capacity()

@rpc("any_peer", "call_local", "reliable")
func interact(player_name : String):
	if is_multiplayer_authority():
		print("aaaa")
		var player = get_node("../" + player_name)
		if !player.carry_addr.is_empty():
				add_box.rpc(player.name)
		else:
			if player.carry_id < 0:
				get_node("../Tiri").send_off()

@rpc("any_peer", "call_local", "reliable")
func add_box(player_name : String) -> void:
	if is_multiplayer_authority():
		var player = get_node("../" + player_name)
	
		if items + player.carry_count > max_capacity:
			print("Area is full")
			return
		
		var carry_id = player.carry_id
		var carry_count = player.carry_count
		var carry_addr = player.carry_addr
		add_to_cache(carry_id, carry_count, carry_addr)
		
		items += carry_count
		# If such a box already exists, add to it, otherwise put it in
		if inventory.has(carry_id):
			inventory[carry_id] += carry_count
		else:
			inventory[carry_id] = carry_count
		
		remove_from_player.rpc(player.name)


@rpc("any_peer", "call_local", "reliable")
func remove_from_player(player_name):
	get_node("../" + player_name).set_carry_id(-1)
	get_node("../" + player_name).set_carry_addr("")
	get_node("../" + player_name).set_carry_count(0)
	get_node("../" + player_name).get_node("Box").hide()


func evaluate_capacity() -> void:
	items = 0
	for value in inventory.values():
		items += value


func clear() -> void:
	items = 0
	inventory = {}

func add_to_cache(id: int, count: int, address: String) -> void:
	var new_item: Dictionary[String, Variant] = {
		"address": address,
		"id": id,
		"count": count
	}
	
	cache.append(new_item)
