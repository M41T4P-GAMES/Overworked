extends Control

func _physics_process(_delta: float) -> void:
	$TextureRect/Label.text = "$" + str(GameStats.money)


func update_timer(time_remaining: int):
	var minutes = int(floor(time_remaining / 60))
	var seconds = int(time_remaining % 60)
	$TextureRect/Label2.text = "0" + str(minutes) + ":" + ("0" if seconds < 10 else "") + str(seconds)
