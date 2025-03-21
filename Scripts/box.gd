extends StaticBody2D

@export var item_id: int
@export var count: int
@export var uname: String

func _ready() -> void:
	if get_node("../../").is_in_group("Player"):
		set_multiplayer_authority(int(get_node("../../").name))

func init(id: int, num: int, title: String, texture: Texture2D) -> void:
	item_id = id
	count = num
	uname = title
	#$ItemSprite.set_texture(texture)
