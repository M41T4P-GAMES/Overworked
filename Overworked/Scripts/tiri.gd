extends Node2D


func _ready() -> void:
	if is_multiplayer_authority():
		$Incoming/AnimatedSprite2D.play("move")
		$Outgoing/AnimatedSprite2D.play("move")

func send_off() -> void:
	if is_multiplayer_authority():
		$Outgoing/AnimationPlayer.play("take_off")


func _on_call_timeout() -> void:
	if is_multiplayer_authority():
		$Outgoing/AnimationPlayer.play("pull_up")


# This is outgoing
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "take_off":
		var exports = get_node("../Exports")
		exports.clear()
		$Outgoing/Call.start(randi_range(15, 25))
		GameStats.add_money_earned.rpc(50)
		GameStats.increment_trucks.rpc()
		GameStats.increment_items.rpc()



# This is incoming
func _on_incoming_animation_player_animation_finished(anim_name: StringName) -> void:
	if is_multiplayer_authority():
		if anim_name == "pull_up":
			var intake = get_node("../Intake")
			intake.generate_items.rpc()
		if anim_name == "take_off":
			$Incoming/Call.start(randi_range(15, 25))


func _on_intake_call_timeout() -> void:
	if is_multiplayer_authority():
		$Incoming/AnimationPlayer.play("pull_up")
