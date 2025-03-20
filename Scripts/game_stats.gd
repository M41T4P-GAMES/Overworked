extends Node

class GameStats:
	var moneyEarned
	var totalMoneyEarned
	var moneySpent
	var totalMoneySpent
	var daysPassed
	var mistakesMade
	var totalMistakesMade
	var difficulty
	var trucksSent
	var totalTrucksSent
	var itemsMade
	var totalItemsMade
	var inventory
	
	func _init(moneyAlreadyEarned, moneyAlreadySpent, daysAlreadyPassed, mistakesAlreadyMade, newDifficulty, trucksAlreadySent, itemsAlreadyMade):
		totalMoneyEarned = moneyAlreadyEarned
		totalMoneySpent = moneyAlreadySpent
		daysPassed = daysAlreadyPassed
		totalMistakesMade = mistakesAlreadyMade
		difficulty = newDifficulty
		totalTrucksSent = trucksAlreadySent
		itemsMade = itemsAlreadyMade
		
	func end_shift():
		totalMoneyEarned += moneyEarned
		daysPassed += 1
		totalMistakesMade += mistakesMade
		difficulty *= 1.07
		totalTrucksSent += trucksSent
		totalItemsMade += itemsMade
	
	func increment_mistakes():
		mistakesMade += 1
		
	func increment_trucks():
		trucksSent += 1
	
	func increment_items():
		itemsMade += 1
	
	func calculate_maintenance_costs():
		return difficulty * (trucksSent * 10 + itemsMade * 4)
		
	func get_report():
		return "Daily Report (Day " + str(daysPassed) + \
		")\nItems made: " + str(itemsMade) + \
		"\nTrucks sent: " + str(trucksSent) + \
		"\nMistakes made: " + str(mistakesMade) + \
		"\nMoney earned: " + str(moneyEarned) + \
		"\nMoney spent: " + str(moneySpent) + \
		"\nMaintenance costs: " + calculate_maintenance_costs() + \
		"\nNet profit: " + str(moneyEarned - moneySpent - calculate_maintenance_costs())
