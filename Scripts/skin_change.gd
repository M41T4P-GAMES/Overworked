extends Camera2D


func _on_r_value_changed(value: float) -> void:
	$Preview.self_modulate.r = value


func _on_g_value_changed(value: float) -> void:
	$Preview.self_modulate.g = value


func _on_b_value_changed(value: float) -> void:
	$Preview.self_modulate.b = value


func _on_join_server_pressed() -> void:
	Global.skin_color = $Preview.self_modulate
	
