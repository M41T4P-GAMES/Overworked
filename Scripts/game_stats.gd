extends Node

var money = 0
var moneyEarned = 0
var totalMoneyEarned = 0
var moneySpent = 0
var totalMoneySpent = 0
var daysPassed = 0
var mistakesMade = 0
var totalMistakesMade = 0
var difficulty = 1
var trucksSent = 0
var totalTrucksSent = 0
var itemsMade = 0
var totalItemsMade = 0
var acceptedOrders = []
var availableOrders = []
var totalScore = 0

#func _init(moneyAlreadyEarned, moneyAlreadySpent, daysAlreadyPassed, mistakesAlreadyMade, newDifficulty, trucksAlreadySent, itemsAlreadyMade, totalScoredPoints):
	#totalScore = totalScoredPoints
	#totalMoneyEarned = moneyAlreadyEarned
	#totalMoneySpent = moneyAlreadySpent
	#daysPassed = daysAlreadyPassed
	#totalMistakesMade = mistakesAlreadyMade
	#difficulty = newDifficulty
	#totalTrucksSent = trucksAlreadySent
	#itemsMade = itemsAlreadyMade

@rpc("any_peer", "call_local", "reliable")
func end_shift():
	if multiplayer.is_server():
		totalMoneyEarned += moneyEarned
		daysPassed += 1
		totalMistakesMade += mistakesMade
		difficulty *= 1.1
		totalTrucksSent += trucksSent
		totalItemsMade += itemsMade
		totalScore += difficulty * moneyEarned
		money -= calculate_maintenance_costs()

@rpc("any_peer", "call_local", "reliable")
func increment_mistakes():
	if multiplayer.is_server():
		mistakesMade += 1

@rpc("any_peer", "call_local", "reliable")
func increment_trucks():
	if multiplayer.is_server():
		trucksSent += 1

@rpc("any_peer", "call_local", "reliable")
func increment_items():
	if multiplayer.is_server():
		itemsMade += 1

@rpc("any_peer", "call_local", "reliable")
func add_money_earned(earnedMoney):
	if multiplayer.is_server():
		moneyEarned += earnedMoney
		money += earnedMoney

@rpc("any_peer", "call_local", "reliable")
func add_money_spent(spentMoney):
	if multiplayer.is_server():
		moneySpent += spentMoney
		money -= spentMoney

@rpc("any_peer", "call_local", "reliable")
func add_score(score):
	if multiplayer.is_server():
		totalScore += score

@rpc("any_peer", "call_local", "reliable")
func calculate_maintenance_costs():
	return int(floor(difficulty * (trucksSent * 50 + itemsMade * 20)))
	
func get_report():
	return "Daily Report (Day " + str(daysPassed) + \
	")\nItems made: " + str(itemsMade) + \
	"\nTrucks sent: " + str(trucksSent) + \
	"\nMistakes made: " + str(mistakesMade) + \
	"\nMoney earned: " + str(moneyEarned) + \
	"\nMoney spent: " + str(moneySpent) + \
	"\nMandatory costs: " + str(calculate_maintenance_costs()) + \
	"\nNet profit: " + str(moneyEarned - moneySpent - calculate_maintenance_costs()) + \
	"\nMoney: " + str(money) + \
	"\nScore: " + str(totalScore) + \
	("\nGAME OVER!" if money < 0 else "")
	
func reset():
	money = 0
	moneyEarned = 0
	totalMoneyEarned = 0
	moneySpent = 0
	totalMoneySpent = 0
	daysPassed = 0
	mistakesMade = 0
	totalMistakesMade = 0
	trucksSent = 0
	totalTrucksSent = 0
	itemsMade = 0
	totalItemsMade = 0
	acceptedOrders = []
	availableOrders = []
	totalScore = 0
