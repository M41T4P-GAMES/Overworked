extends Control

var count


func init(id: int, num: int, uname: String, tex: Texture2D) -> void:
	count = num
	name = str(id)
	$TextureButton/Label.text = uname
	$TextureButton/Sprite2D.set_texture(tex)


func _on_texture_button_pressed() -> void:
	get_node("../../../").select(int(name), count, $TextureButton/Sprite2D.texture)
