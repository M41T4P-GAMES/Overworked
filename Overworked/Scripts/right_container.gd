extends PanelContainer

var currentOrder = null

func display_order(order):
	if order == currentOrder:
		visible = false
		currentOrder = null
	else:
		visible = true
		currentOrder = order
		$MarginContainer/VBoxContainer/Label.text = currentOrder.list_products()
		$MarginContainer/VBoxContainer/Label3.text = "Price: " + str(currentOrder.pay) + "$"
		$MarginContainer/VBoxContainer/sender.text = "Sender: " + currentOrder.customerName
		
