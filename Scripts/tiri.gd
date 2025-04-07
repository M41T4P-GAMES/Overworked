extends Node2D


func _ready() -> void:
	$Incoming/AnimatedSprite2D.play("move")
	$Outgoing/AnimatedSprite2D.play("move")


func stock_up() -> void:
	pass

func send_off() -> void:
	$Outgoing/AnimationPlayer.play("take_off")


func _on_call_timeout() -> void:
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
