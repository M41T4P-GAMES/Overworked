extends Node

func _ready():
	$Label.text = GameStats.get_report()
