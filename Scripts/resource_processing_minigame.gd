extends Node2D
var green_start_scale = 1.14
var success_amount = 0
var failed_attempts = 0

func _ready() -> void:
	#debug only
	start_minigame()
	
	green_start_scale = $Green.scale.x
	
func start_minigame():
	$AnimationPlayer.play("arrow")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		if $Arrow in $Green.get_overlapping_bodies():
			success()
		else:
			fail()


func success():
	$Green.scale.x -= randf_range(0.1, 0.3)
	success_amount += 1
	if success_amount == 3:
		win()

func fail():
	$Green.scale.x = green_start_scale
	failed_attempts += 1
	success_amount = 0
	if failed_attempts == 3:
		lose()
	
func win():
	print("You crafted the thing")

func lose():
	print("You lost the materials. STUUUUPID")
