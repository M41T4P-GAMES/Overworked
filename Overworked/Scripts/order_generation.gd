extends Node

var addresses = []
var names = []
var bullshitProducts = []
var materialsAndProducts = null

func parse_json():
	materialsAndProducts = load("res://Scripts/materials_and_products.gd").new()
	materialsAndProducts.parse_json()
	print(materialsAndProducts)
	var addressesFile = FileAccess.open("res://Assets/Data/addresses.json", FileAccess.READ)
	addresses = JSON.parse_string(addressesFile.get_as_text())
	addressesFile.close()
	var namesFile = FileAccess.open("res://Assets/Data/names.json", FileAccess.READ)
	names = JSON.parse_string(namesFile.get_as_text())
	namesFile.close()
	var bullshitProductsFile = FileAccess.open("res://Assets/Data/bullshit_products.json", FileAccess.READ)
	var bullshitProductsData = JSON.parse_string(bullshitProductsFile.get_as_text())
	bullshitProductsFile.close()
	for bullshitProduct in bullshitProductsData:
		bullshitProducts.append(materialsAndProducts.Product.new(bullshitProduct.id, bullshitProduct.name, null, null))
	#for i in range(100):
		#print(generate_random_order())

class Order:
	var orderProducts: Array
	var counts: Array
	var pay: int
	var customerName: String
	var customerAddress: String
	
	func _init(newProducts, newCounts, newPay, newCustomerName, newCustomerAddress):
		orderProducts = newProducts
		counts = newCounts
		pay = newPay
		customerName = newCustomerName
		customerAddress = newCustomerAddress
		
	func _to_string():
		var firstPartOfString = ""
		for orderProduct in orderProducts:
			var currentCount = counts[orderProducts.find(orderProduct)]
			firstPartOfString += str(currentCount) + " " + orderProduct.productName + ("s" if currentCount > 1 else "") + (", " if orderProducts.find(orderProduct) < orderProducts.size() - 1 else "")
		return "Products: " + firstPartOfString + "\nPay: "+ str(pay) + "\nCustomer: " + customerName + "\nAddress: " + customerAddress
	
	func list_products():
		var firstPartOfString = ""
		for orderProduct in orderProducts:
			var currentCount = counts[orderProducts.find(orderProduct)]
			firstPartOfString += str(currentCount) + " " + orderProduct.productName + ("s" if currentCount > 1 else "") + ("\n- " if orderProducts.find(orderProduct) < orderProducts.size() - 1 else "")
		return "Order:\n- " + firstPartOfString
		
func generate_random_order():
	var randomProductCount = randi_range(1, int(materialsAndProducts.products.size() / 1.5))
	var randomPay = 0
	var remainingProducts = []
	for product in materialsAndProducts.products:
		remainingProducts.append(product)
	var theProducts = []
	var theCounts = []
	for i in range(randomProductCount):
		var randomProduct = remainingProducts.pick_random()
		remainingProducts.erase(randomProduct)
		theProducts.append(randomProduct)
		var randomCount = randi_range(1, 10)
		theCounts.append(randomCount)
		randomPay += int(floor(calculate_product_price(randomProduct) * randf_range(0.7, 1.6) * randomCount))
	var randomName = names.pick_random()
	var randomAddress = addresses.pick_random()
	
	var result = Order.new(theProducts, theCounts, randomPay, randomName, randomAddress)
	bullshitify_order(result)
	return result

func get_material(materialId):
	for material in materialsAndProducts.materials:
		if material.id == materialId:
			return material
	return null
	
func get_product(productId):
	for product in materialsAndProducts.products:
		if product.id == productId:
			return product
	return null
	
func calculate_product_price(product):
	var curPrice = 0
	for cost in product.materialCosts:
		curPrice += get_material(cost.materialId).pricePerUnit * cost.count
	return curPrice
	
func bullshitify_order(order):
	if randi_range(1, 100) > 90:
		var currentBullshit = randi_range(1, 3)
		if currentBullshit == 1:
			order.pay /= 20
		elif currentBullshit == 2:
			order.counts[0] = randi_range(1000, 2000000)
		elif currentBullshit == 3:
			order.orderProducts.clear()
			order.orderProducts.append(bullshitProducts.pick_random())
		
	
