extends PanelContainer

var order = null

func _ready():
	pass

func display_order(orderToDisplay, rightContainer):
	$MarginContainer/HBoxContainer/sender.text = orderToDisplay.customerName
	$MarginContainer/HBoxContainer/price.text = "$" + str(orderToDisplay.pay)
	order = orderToDisplay
	$MarginContainer/HBoxContainer/Button.order = order
	$MarginContainer/HBoxContainer/Button.rightContainer = rightContainer
