extends CanvasLayer

# CRASHES WITHOUT YIELD

func _on_NextLevel_pressed():
	get_tree().paused = false
	Global.current_level += 1
	yield(get_tree().create_timer(0.01), "timeout")
	get_tree().change_scene("res://scenes/levels/Level" + str(Global.current_level) + ".tscn")
	visible = false

func _on_Quit_pressed():
	get_tree().quit()

func _on_LevelSelect_pressed():
	get_tree().paused = false
	yield(get_tree().create_timer(0.01), "timeout")
	get_tree().change_scene("res://scenes/LevelSelect.tscn")
	visible = false
