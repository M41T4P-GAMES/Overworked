extends Timer
@onready var label = get_node("../HUD/LeUi/TextureRect/Timer")

func _on_timeout() -> void:
	GameStats.end_shift()
	if is_multiplayer_authority():
		get_node("../Report").show_report.rpc()
		


func _process(delta: float) -> void:
	if is_multiplayer_authority():
		var mins = int(time_left / 60)
		var secs = int(time_left - (mins * 60))
		if secs >= 10:
			label.text = "0" + str(mins) + ":" + str(secs)
		else:
			label.text = "0" + str(mins) + ":0" + str(secs)
