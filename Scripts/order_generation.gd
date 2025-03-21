extends Node

var addresses = []
var names = []
var materials = []
var products = []
var bullshitProducts = []

func _ready():
	var addressesFile = FileAccess.open("res://Assets/Data/addresses.json", FileAccess.READ)
	addresses = JSON.parse_string(addressesFile.get_as_text())
	addressesFile.close()
	var namesFile = FileAccess.open("res://Assets/Data/names.json", FileAccess.READ)
	names = JSON.parse_string(namesFile.get_as_text())
	namesFile.close()
	var materialsAndProductsFile = FileAccess.open("res://Assets/Data/materials_and_products.json", FileAccess.READ)
	var materialsAndProductsData = JSON.parse_string(materialsAndProductsFile.get_as_text())
	materialsAndProductsFile.close()
	var bullshitProductsFile = FileAccess.open("res://Assets/Data/bullshit_products.json", FileAccess.READ)
	var bullshitProductsData = JSON.parse_string(bullshitProductsFile.get_as_text())
	bullshitProductsFile.close()
	var recipesFile = FileAccess.open("res://Assets/Data/recipes.json", FileAccess.READ)
	var recipesData = JSON.parse_string(recipesFile.get_as_text())
	recipesFile.close()
	for thingymajig in materialsAndProductsData:
		var currentId: int = thingymajig.id
		var currentName: String = thingymajig.name
		var currentSpritePath: String = thingymajig.sprite
		if thingymajig.type == "Material":
			var currentPPU = thingymajig.price
			var currentMaterial = BuildingMaterial.new(currentId, currentName, currentSpritePath, currentPPU)
			materials.append(currentMaterial)
		else:
			var currentMaterials = null
			for recipe in recipesData:
				if recipe.productId == currentId:
					currentMaterials = recipe.materials
			var currentProduct = Product.new(currentId, currentName, currentSpritePath, currentMaterials)
			products.append(currentProduct)
	for bullshitProduct in bullshitProductsData:
		bullshitProducts.append(Product.new(bullshitProduct.id, bullshitProduct.name, null, null))
	#print(materials)
	#print(products)
	#for i in range(100):
		#print(generate_random_order())


class BuildingMaterial:
	var id: int
	var materialName: String
	var spritePath: String
	var pricePerUnit: int
	
	func _init(newId, newMaterialName, newSpritePath, newPricePerUnit):
		id = newId
		materialName = newMaterialName
		spritePath = newSpritePath
		pricePerUnit = newPricePerUnit
	

class Product:
	var id: int
	var productName: String
	var spritePath
	var materialCosts
	
	func _init(newId, newProductName, newSpritePath, newMaterialCosts):
		id = newId
		productName = newProductName
		spritePath = newSpritePath
		materialCosts = newMaterialCosts
			
	
#var materials = [
	#BuildingMaterial.new(MaterialTypes.WOOD, 20),
	#BuildingMaterial.new(MaterialTypes.GLASS, 40),
	#BuildingMaterial.new(MaterialTypes.RUBBER, 30),
	#BuildingMaterial.new(MaterialTypes.PLASTIC, 50),
	#BuildingMaterial.new(MaterialTypes.IRON, 60)
#]

#var products = [
	#Product.new(ProductTypes.CHAIR, [[MaterialTypes.WOOD, 5], [MaterialTypes.IRON, 2]]),
	#Product.new(ProductTypes.TABLE, [[MaterialTypes.WOOD, 10], [MaterialTypes.IRON, 3]]),
	#Product.new(ProductTypes.DOOR, [[MaterialTypes.WOOD, 12], [MaterialTypes.GLASS, 4]]),
	#Product.new(ProductTypes.WINDOW, [[MaterialTypes.GLASS, 10], [MaterialTypes.IRON, 2]]),
#]

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
		
func generate_random_order():
	var randomProductCount = randi_range(1, products.size())
	var randomPay = 0
	var remainingProducts = []
	for product in products:
		remainingProducts.append(product)
	var theProducts = []
	var theCounts = []
	for i in range(randomProductCount):
		var randomProduct = remainingProducts.pick_random()
		remainingProducts.erase(randomProduct)
		theProducts.append(randomProduct)
		var randomCount = randi_range(1, 20)
		theCounts.append(randomCount)
		randomPay += int(floor(calculate_product_price(randomProduct) * randf_range(0.7, 1.6) * randomCount))
	var randomName = names.pick_random()
	var randomAddress = addresses.pick_random()
	
	var result = Order.new(theProducts, theCounts, randomPay, randomName, randomAddress)
	bullshitify_order(result)
	return result

func get_material(materialId):
	for material in materials:
		if material.id == materialId:
			return material
	return null
	
func get_product(productId):
	for product in products:
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
		
	
