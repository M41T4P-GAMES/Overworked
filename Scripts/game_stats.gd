extends Node

var money = 10000
var moneyEarned = 0
var totalMoneyEarned = 0
var moneySpent = 0
var totalMoneySpent = 0
var daysPassed = 0
var mistakesMade = 0
var totalMistakesMade = 0
var difficulty = 0
var trucksSent = 0
var totalTrucksSent = 0
var itemsMade = 0
var totalItemsMade = 0
var inventory = []
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
	
func end_shift():
	totalMoneyEarned += moneyEarned
	daysPassed += 1
	totalMistakesMade += mistakesMade
	difficulty *= 1.1
	totalTrucksSent += trucksSent
	totalItemsMade += itemsMade
	totalScore += difficulty * moneyEarned

func increment_mistakes():
	mistakesMade += 1
	
func increment_trucks():
	trucksSent += 1

func increment_items():
	itemsMade += 1

func add_money_earned(earnedMoney):
	moneyEarned += earnedMoney
	money += earnedMoney

func add_money_spent(spentMoney):
	moneySpent += spentMoney
	money -= spentMoney

func add_score(score):
	totalScore += score

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
