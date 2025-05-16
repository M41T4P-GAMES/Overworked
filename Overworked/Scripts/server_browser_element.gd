extends HBoxContainer
var ip
var player_count
signal on_clicked(ip)

func _ready() -> void:
	$ip.text = ip
	$player_count.text = str(int(player_count)) + "/4 Players"


func _on_button_pressed() -> void:
	on_clicked.emit($ip.text)
