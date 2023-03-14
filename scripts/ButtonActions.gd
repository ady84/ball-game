extends CanvasLayer

func _on_Start_pressed():
	# CRASHES AFTER SPAM CLICKING BUTTON (DISABLE USER INPUT FOR A BIT AFTER LOADING LEVEL?)
	yield(get_tree().create_timer(0.01), "timeout")
	get_tree().change_scene("res://scenes/LevelSelect.tscn")

func _on_Quit_pressed():
	get_tree().quit()
