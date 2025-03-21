extends Node2D


func _on_button_pressed() -> void:
	$Button.disabled = true
	$LineEdit.editable = false
	$Label.text = $LineEdit.text
	$AnimationPlayer.play("stamp")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "appear":
		$Button.disabled = false
		$LineEdit.editable = true
	elif anim_name == "stamp":
		$AnimationPlayer.play("disappear")
