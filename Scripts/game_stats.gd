extends Node

class GameStats:
	var moneyEarned
	var totalMoneyEarned
	var daysPassed
	var mistakesMade
	var totalMistakesMade
	var difficulty
	var trucksSent
	var totalTrucksSent
	var itemsMade
	var totalItemsMade
	
	func _init(moneyAlreadyEarned, daysAlreadyPassed, mistakesAlreadyMade, newDifficulty, trucksAlreadySent, itemsAlreadyMade):
		totalMoneyEarned = moneyAlreadyEarned
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
		return difficulty * (trucksSent * 10 + itemsMade * 5)
		
		
