extends CanvasLayer

# CRASHES WITHOUT YIELD

var paused = 0

func _process(_delta):
	# ESC, P PAUSES AND UNPAUSES
	if Input.is_action_just_pressed("pause"):
		if (paused):
			yield(get_tree().create_timer(0.01), "timeout")
			get_tree().paused = false
			visible = false
			paused = 0
		else:
			get_tree().paused = true
			visible = true
			paused = 1

func _on_Resume_pressed():
	yield(get_tree().create_timer(0.01), "timeout")
	get_tree().paused = false
	visible = false
	paused = 0

func _on_Quit_pressed():
	get_tree().quit()

func _on_LevelSelect_pressed():
	yield(get_tree().create_timer(0.01), "timeout")
	get_tree().paused = false
	visible = false
	paused = 0
	get_tree().change_scene("res://scenes/LevelSelect.tscn")
