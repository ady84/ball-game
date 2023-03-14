extends Area2D

onready var level_end_text = get_parent().get_node("HUD/LevelEndText")
onready var level_timer = get_parent().get_node("HUD/LevelTimer")
onready var ball = get_parent().get_node("Ball/AimLine")
onready var level_complete_screen = get_parent().get_node("LevelComplete")

func _on_Area2D_body_entered(body):
	if body.get_name() == "Ball":
		level_complete_screen.get_node("CompleteText").text = "Finished in %s seconds with %s strokes!" % [stepify(level_timer.elapsed, 0.1), ball.strokes]
		yield(get_tree().create_timer(1), "timeout")
		level_complete_screen.visible = true
		get_tree().paused = true
