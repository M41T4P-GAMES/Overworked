extends Node

var addresses = []
var names = []

func _ready():
	var addressesFile = FileAccess.open("res://Assets/Data/addresses.json", FileAccess.READ)
	addresses = JSON.parse_string(addressesFile.get_as_text())
	var namesFile = FileAccess.open("res://Assets/Data/names.json", FileAccess.READ)
	names = JSON.parse_string(namesFile.get_as_text())
	for i in range(10):
		print(generate_random_order())
		print("\n")

enum MaterialTypes {WOOD, GLASS, RUBBER, IRON, PLASTIC}
enum ProductTypes {CHAIR, TABLE, DOOR, WINDOW}

class BuildingMaterial:
	var materialType
	var pricePerUnit
	
	func _init(newMaterialType, newPricePerUnit):
		materialType = newMaterialType
		pricePerUnit = newPricePerUnit
	

class Product:
	var productType
	var materialCosts
	
	func _init(newProductType, newMaterialCosts):
		productType = newProductType
		materialCosts = newMaterialCosts
			
	
var materials = [
	BuildingMaterial.new(MaterialTypes.WOOD, 20),
	BuildingMaterial.new(MaterialTypes.GLASS, 40),
	BuildingMaterial.new(MaterialTypes.RUBBER, 30),
	BuildingMaterial.new(MaterialTypes.PLASTIC, 50),
	BuildingMaterial.new(MaterialTypes.IRON, 60)
]

var products = [
	Product.new(ProductTypes.CHAIR, [[MaterialTypes.WOOD, 5], [MaterialTypes.IRON, 2]]),
	Product.new(ProductTypes.TABLE, [[MaterialTypes.WOOD, 10], [MaterialTypes.IRON, 3]]),
	Product.new(ProductTypes.DOOR, [[MaterialTypes.WOOD, 12], [MaterialTypes.GLASS, 4]]),
	Product.new(ProductTypes.WINDOW, [[MaterialTypes.GLASS, 10], [MaterialTypes.IRON, 2]]),
]

class Order:
	var productTypes
	var counts
	var pay
	var customerName
	var customerAddress
	
	func _init(newProductTypes, newCounts, newPay, newCustomerName, newCustomerAddress):
		productTypes = newProductTypes
		counts = newCounts
		pay = newPay
		customerName = newCustomerName
		customerAddress = newCustomerAddress
		
	func _to_string():
		var firstPartOfString = ""
		for productType in productTypes:
			var currentCount = counts[productTypes.find(productType)]
			firstPartOfString += str(currentCount) + " " + ProductTypes.keys()[productType].to_lower() + ("s" if currentCount > 1 else "") + (", " if productTypes.find(productType) < productTypes.size() - 1 else "")
		return "Products: " +firstPartOfString + "\nPay: "+ str(pay) + "\nCustomer: " + customerName + "\nAddress: " + customerAddress
		
func generate_random_order():
	var randomProductCount = randi_range(1, products.size())
	var randomPay = 0
	var remainingTypes = ProductTypes.values()
	var theTypes = []
	var theCounts = []
	for i in range(randomProductCount):
		var randomProductType = remainingTypes.pick_random()
		remainingTypes.erase(randomProductType)
		theTypes.append(randomProductType)
		var randomCount = randi_range(1, 20)
		theCounts.append(randomCount)
		randomPay += int(floor(calculate_product_price(get_product(randomProductType)) * randf_range(0.9, 1.3) * randomCount))
	var randomName = names.pick_random()
	var randomAddress = addresses.pick_random()
	
	var result = Order.new(theTypes, theCounts, randomPay, randomName, randomAddress)
	return result

func get_material(materialType):
	for material in materials:
		if material.materialType == materialType:
			return material
	return null
	
func get_product(productType):
	for product in products:
		if product.productType == productType:
			return product
	return null
	
func calculate_product_price(product):
	var curPrice = 0
	for cost in product.materialCosts:
		curPrice += get_material(cost[0]).pricePerUnit * cost[1]
	return curPrice
