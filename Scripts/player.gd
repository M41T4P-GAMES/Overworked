extends RigidBody2D

const SPEED = 65
const MAX_SPEED = 400
var selected_area = null
var item_tab = preload("res://Scenes/item_tab.tscn")
var facing : Vector2i

@export var carry_id = -1
@export var carry_count = 0
@export var carry_addr = ""

func _ready() -> void:
	set_multiplayer_authority(int(name))
	if multiplayer.get_unique_id() == int(name):
		$Camera2D.enabled = true
		$Sprite2D.self_modulate = Global.skin_color
	$CanvasLayer/CraftingUI.set_input_area(get_node("../WorkbenchMaterialArea"))


func _input(event: InputEvent) -> void:
	if is_multiplayer_authority():
		if event.is_action_pressed("interact") and selected_area != null:
			selected_area.interact.rpc(name)


func _physics_process(_delta: float) -> void:
	if is_multiplayer_authority():
		var input := Input.get_vector("left", "right", "up", "down")
		
		if input != Vector2.ZERO:
			linear_velocity.x = move_toward(linear_velocity.x, input.x * MAX_SPEED, SPEED)
			linear_velocity.y = move_toward(linear_velocity.y, input.y * MAX_SPEED, SPEED)
		else:
			linear_velocity.x = move_toward(linear_velocity.x, 0, SPEED)
			linear_velocity.y = move_toward(linear_velocity.y, 0, SPEED)
		 
		
		#Animations
		if input != Vector2.ZERO:
			if input.x < 0 and input.y < 0:
				$Sprite2D.flip_h = true
				$Sprite2D.play("walking_back_right")
				
			elif input.x > 0 and input.y < 0:
				$Sprite2D.flip_h = false
				$Sprite2D.play("walking_back_right")
				facing = Vector2i(1, -1)
			elif input.x < 0 and input.y > 0:
				$Sprite2D.flip_h = true
				$Sprite2D.play("walking_front_right")
				facing = Vector2i(-1, 1)
			elif input.x > 0 and input.y > 0:
				$Sprite2D.flip_h = false
				$Sprite2D.play("walking_front_right")
				facing = Vector2i(1, 1)
			elif input == Vector2.UP:
				$Sprite2D.flip_h = false
				$Sprite2D.play("walking_back")
				facing = Vector2i.UP
			elif input == Vector2.DOWN:
				$Sprite2D.flip_h = false
				$Sprite2D.play("walking_front")
				facing = Vector2i.DOWN
			elif input == Vector2.LEFT:
				$Sprite2D.flip_h = true
				$Sprite2D.play("walking_right")
				facing = Vector2i.LEFT
			elif input == Vector2.RIGHT:
				$Sprite2D.flip_h = false
				$Sprite2D.play("walking_right")
				facing = Vector2i.RIGHT
		else:
			if facing.x < 0 and facing.y < 0:
				$Sprite2D.flip_h = true
				$Sprite2D.play("idle_back_right")
				
			elif facing.x > 0 and facing.y < 0:
				$Sprite2D.flip_h = false
				$Sprite2D.play("idle_back_right")
				
			elif facing.x < 0 and facing.y > 0:
				$Sprite2D.flip_h = true
				$Sprite2D.play("idle_front_right")
				
			elif facing.x > 0 and facing.y > 0:
				$Sprite2D.flip_h = false
				$Sprite2D.play("idle_front_right")
				
			elif facing == Vector2i.UP:
				$Sprite2D.flip_h = false
				$Sprite2D.play("idle_back")
				
			elif facing == Vector2i.DOWN:
				$Sprite2D.flip_h = false
				$Sprite2D.play("idle_front")
				
			elif facing == Vector2i.LEFT:
				$Sprite2D.flip_h = true
				$Sprite2D.play("idle_right")
				
			elif facing == Vector2i.RIGHT:
				$Sprite2D.flip_h = false
				$Sprite2D.play("idle_right")

@rpc("any_peer", "call_local", "reliable")
func open_storage_ui(inv: Dictionary) -> void:
	if is_multiplayer_authority():
		freeze = true
		$BoxStorage/UI/BottomButtons.hide()
		$BoxStorage/UI.update_inv(inv)
		$BoxStorage.show()
		
		if inv.is_empty():
			return
		
		for key in inv.keys():
			var new_item = item_tab.instantiate()
			var entry: Dictionary = Global.get_entry_by_id("res://Assets/Data/materials_and_products.json", key)
			new_item.init(int(key), inv[key], entry["name"], load(entry["sprite"]))
			$BoxStorage/UI/ScrollContainer/ItemList.add_child(new_item)

func close_storage_ui() -> void:
	if is_multiplayer_authority():
		freeze = false
		$BoxStorage.hide()
		selected_area.remove_item.rpc(name, carry_id, carry_count)
		for i in $BoxStorage/UI/ScrollContainer/ItemList.get_children():
			i.queue_free()


func open_stamping():
	$Stamper/UI/AnimationPlayer.play("appear")
	freeze = true

func close_stamping(text: String):
	selected_area.taken = false
	carry_addr = text
	freeze = false
	
func open_crafting():
	$CanvasLayer/CraftingUI.visible = true
	$CanvasLayer/CraftingUI.on_open(self)
	freeze = true

func close_crafting():
	selected_area.taken = false
	$CanvasLayer/CraftingUI.visible = false
	#$CanvasLayer/CraftingUI.on_close()
	freeze = false

func clear_storage_ui() -> void:
	for i in $BoxStorage/UI/ScrollContainer/ItemList.get_children():
			i.queue_free()

func create_storage_ui(inv: Dictionary) -> void:
	for key in inv.keys():
		var new_item = item_tab.instantiate()
		var entry: Dictionary = Global.get_entry_by_id("res://Assets/Data/materials_and_products.json", key)
		new_item.init(int(key), inv[key], entry["name"], load(entry["sprite"]))
		$BoxStorage/UI/ScrollContainer/ItemList.add_child(new_item)

func refresh_storage_ui(inv: Dictionary):
	clear_storage_ui()
	create_storage_ui(inv)





func _on_pickup_range_area_entered(area: Area2D) -> void:
	if is_multiplayer_authority():
		selected_area = area

func _on_pickup_range_area_exited(area: Area2D) -> void:
	if is_multiplayer_authority():
		selected_area = null


func get_carry_id() -> int:
	return carry_id

func get_carry_count() -> int:
	return carry_count

func set_carry_id(id: int) -> void:
	carry_id = id

func set_carry_count(count: int) -> void:
	carry_count = count

func set_carry_addr(addr: String) -> void:
	carry_addr = addr
