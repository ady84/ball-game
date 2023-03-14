extends Line2D

# NO COOLDOWN BALL FOR MAIN MENU

onready var ball = get_parent()
var ball_pos
var mouse_pos
var inverse_vector
export var impulse_speed = 2.5

func _process(_delta):
	if Input.is_action_pressed("launch"):
		remove_line()
		ball_pos = position
		mouse_pos = get_local_mouse_position()
		inverse_vector = get_negative_vector(ball_pos, mouse_pos)
		create_line(ball_pos, inverse_vector)
		if Input.is_action_pressed("cancel"):
			remove_line()
			
	if not Input.is_action_pressed("cancel"):
		if Input.is_action_just_released("launch"):
			remove_line()
			ball.apply_central_impulse(inverse_vector.rotated(ball.rotation) * impulse_speed)
		
func create_line(from, to):
	add_point(from)
	add_point(to)
	
func remove_line():
	points = []
	
func get_negative_vector(origin_vector, destination_vector):
	return (destination_vector - origin_vector).tangent().tangent() + origin_vector
