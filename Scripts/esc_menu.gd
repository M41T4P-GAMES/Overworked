extends CanvasLayer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		$Panel.visible = !$Panel.visible
		if $Panel.visible:
			get_node("../" + str(multiplayer.get_unique_id())).freeze = true
		else:
			get_node("../" + str(multiplayer.get_unique_id())).freeze = false

func _on_resume_pressed() -> void:
	$Panel.hide()
	get_node("../" + str(multiplayer.get_unique_id())).freeze = false

func _on_disconnect_pressed() -> void:
	multiplayer.multiplayer_peer = null
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
