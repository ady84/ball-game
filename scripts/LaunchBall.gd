extends Line2D

onready var ball = get_parent()
onready var cd = ball.get_node("Cooldown")
onready var hud = ball.get_parent().get_node("HUD")
onready var cooldowntext = hud.get_node("OnCooldown")
var ball_pos
var mouse_pos
var inverse_vector
var strokes = 0
export var impulse_speed = 2.5 # HOW FAST TO MAKE THE BALL GO

func _process(_delta):
	# COOLDOWN HUD DISPLAY
	cooldowntext.text = "CD %s" % stepify(cd.time_left, 0.1)
	if not is_on_cooldown():
		hud.get_node("OnCooldown").visible = false
		hud.get_node("CooldownReady").visible = true
	else:
		hud.get_node("OnCooldown").visible = true
		hud.get_node("CooldownReady").visible = false
		
	if Input.is_action_pressed("launch"):
		remove_line()
		ball_pos = position
		mouse_pos = get_local_mouse_position()
		# IMPULSE VECTOR (MOUSE TO BALL)
		inverse_vector = get_negative_vector(ball_pos, mouse_pos)
		
		# CLAMP VECTOR? WEIRD ROTATING LINE
		#inverse_vector.x = clamp(inverse_vector.x, -500, 500)
		#inverse_vector.y = clamp(inverse_vector.y, -500, 500)
		
		if is_on_cooldown():
			default_color = Color(255, 0 , 0)
		else:
			default_color = Color(0, 255 , 0)
		create_line(ball_pos, inverse_vector)
		if Input.is_action_pressed("cancel"):
			remove_line()
			
	if not Input.is_action_pressed("cancel"):
		if Input.is_action_just_released("launch"):
			remove_line()
			if not is_on_cooldown():
				# IMPULSE VECTOR ROTATES WITH BALL
				ball.apply_central_impulse(inverse_vector.rotated(ball.rotation) * impulse_speed)
				cd.start()
				strokes += 1

# LINE PREVIEW
func create_line(from, to):
	add_point(from)
	add_point(to)
	
func remove_line():
	points = []
	
func get_negative_vector(origin_vector, destination_vector):
	return (destination_vector - origin_vector).tangent().tangent() + origin_vector
	
func is_on_cooldown():
	return cd.time_left
