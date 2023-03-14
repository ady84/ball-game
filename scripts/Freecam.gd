extends Camera2D

onready var ball = get_parent().get_node("Ball")
onready var hud = get_parent().get_node("HUD")
export var speed = 25 # FREECAM SPEED
var lockon = 1

func _process(_delta):
	# TOGGLE LOCKON AND HUD
	if Input.is_action_just_pressed("freecam"):
		if (lockon):
			lockon = 0
			hud.get_node("Freecam").visible = true
			hud.get_node("Circle").visible = true
		else:
			lockon = 1
			hud.get_node("Freecam").visible = false
			hud.get_node("Circle").visible = false
	if (lockon):
		set_position(ball.position)
	else:
		if Input.is_action_pressed("freecam_up"):
			position.y -= speed
		if Input.is_action_pressed("freecam_down"):
			position.y += speed
		if Input.is_action_pressed("freecam_left"):
			position.x -= speed
		if Input.is_action_pressed("freecam_right"):
			position.x += speed
	# "SMOOTH" ZOOM OUT
	if Input.is_action_pressed("zoom_out"):
		zoom.x = clamp(zoom.x, 1.5, 2.5)
		zoom.y = clamp(zoom.y, 1.5, 2.5)
		zoom += Vector2(0.15, 0.15)
	if Input.is_action_just_released("zoom_out"):
		zoom = Vector2(1.5, 1.5)
