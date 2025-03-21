extends Button

var product = null
var craftingContainer = null

func _on_pressed() -> void:
	craftingContainer.craft(product)
