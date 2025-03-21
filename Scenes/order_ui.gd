extends PanelContainer

func _ready():
	pass

func display_order(order):
	$MarginContainer/HBoxContainer/sender.text = order.customerName
	$MarginContainer/HBoxContainer/price.text = "$" + order.pay
