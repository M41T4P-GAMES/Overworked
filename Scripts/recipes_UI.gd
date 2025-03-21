extends Control

var materialsAndProducts = null
var craftableProducts = []
var inputArea = null
var recipeContainer = null
const buttonPrefab = preload("res://Scenes/craft_button.tscn")
const spritePrefab = preload("res://Scenes/product_sprite.tscn")

func _ready() -> void:
	load_materials_and_products()
	recipeContainer = get_node("PanelContainer/MarginContainer/VBoxContainer/GridContainer")
	on_open()
	
func set_input_area(theArea):
	inputArea = theArea

func load_materials_and_products():
	materialsAndProducts = load("res://Scripts/materials_and_products.gd").new()
	materialsAndProducts.parse_json()
	
func decide_all_possible_products():
	for product in materialsAndProducts.products:
		var ableToCraft = true
		var availableMaterials = inputArea.inventory
		for neededMaterial in product.materialCosts:
			if availableMaterials.has(int(neededMaterial.materialId)):
				if availableMaterials[int(neededMaterial.materialId)] < neededMaterial.count:
					ableToCraft = false
		if ableToCraft:
			craftableProducts.append(product)

func craft(product):
	#var totalItemsInArea = 0
	#for value in outputArea.inventory.values():
		#totalItemsInArea += value
	#if totalItemsInArea < outputArea.max_capacity:
	var ableToCraft = true
	var availableMaterials = inputArea.inventory
	for neededMaterial in product.materialCosts:
		if availableMaterials.has(int(neededMaterial.materialId)):
			if availableMaterials[int(neededMaterial.materialId)] < neededMaterial.count:
				ableToCraft = false
				break
			else:
				availableMaterials[int(neededMaterial.materialId)] -= int(neededMaterial.count)
	#if outputArea.inventory.has(int(product.id)):
		#outputArea.inventory[int(product.id)] += 1
	#else:
		#outputArea.inventory[int(product.id)] = 1
	#else:
		#print("Insufficient capacity")
	
	print("Tried to craft " + product.productName)

func on_open():
	visible = true
	decide_all_possible_products()
	for product in craftableProducts:
		#var nameLabel = Label.new()
		#nameLabel.text = product.productName
		#nameLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		var productSprite = spritePrefab.instantiate()
		recipeContainer.add_child(productSprite)
		var recipeLabel = Label.new()
		recipeLabel.text = materialsAndProducts.stringify_recipe(product)
		recipeLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		recipeContainer.add_child(recipeLabel)
		var currentCraftButton = buttonPrefab.instantiate()
		recipeContainer.add_child(currentCraftButton)
		currentCraftButton.set_deferred("product", product)
		currentCraftButton.set_deferred("craftingContainer", self)

	
func on_close() -> void:
	visible = false
	craftableProducts.clear()
	for node in recipeContainer.get_children():
		recipeContainer.remove_child(node)
		node.queue_free()
