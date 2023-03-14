extends CanvasLayer

# CRASHES WITHOUT YIELD

# CONNECT SIGNALS TO ALL BUTTONS
func _ready():
	for button in get_tree().get_nodes_in_group("level_buttons"):
		button.connect("pressed", self, "_level_button_pressed", [button])

func _level_button_pressed(button):
	Global.current_level = int(button.text)
	yield(get_tree().create_timer(0.01), "timeout")
	get_tree().change_scene("res://scenes/levels/Level" + str(Global.current_level) + ".tscn")
