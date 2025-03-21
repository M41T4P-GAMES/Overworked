extends Node

var materials = []
var products = []

func _ready():
	pass

func parse_json():
	var materialsAndProductsFile = FileAccess.open("res://Assets/Data/materials_and_products.json", FileAccess.READ)
	var materialsAndProductsData = JSON.parse_string(materialsAndProductsFile.get_as_text())
	materialsAndProductsFile.close()
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
