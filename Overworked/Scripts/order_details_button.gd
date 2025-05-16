extends Button

var order = null
var rightContainer = null

func _on_pressed() -> void:
	rightContainer.display_order(order)
