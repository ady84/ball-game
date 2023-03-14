extends RigidBody2D

onready var default_position = get_parent().get_node("SpawnPoint").position
onready var level_timer = get_parent().get_node("HUD/LevelTimer")
onready var level_end_text = get_parent().get_node("HUD/LevelEndText")
onready var cooldown = get_parent().get_node("Ball/Cooldown")
var allow_sound = 0
var init_c
var end_c
	
# RESETS BALL POSITION TO SPAWNPOINT
func _integrate_forces(state):
	if Input.is_action_just_pressed("reset"):
		state.transform = Transform2D(0.0, default_position)

# RESETS TIMER, COOLDOWN
func _process(_delta):
	if Input.is_action_just_pressed("reset"):
		cooldown.stop()
		level_timer.elapsed = 0
		level_end_text.visible = false
		mode = RigidBody2D.MODE_KINEMATIC
		mode = RigidBody2D.MODE_RIGID

# COLLISION SOUND
func _on_Ball_body_entered(body):
	if body.get_parent().name == "Walls":
		init_c = linear_velocity.length()
		if allow_sound == 1:
			# DIFFERENCE BETWEEN COLLISIONS SO THE SOUND DOESN'T SPAM
			if abs(end_c - init_c) > 10:
				if linear_velocity.length() > 500:
					$HardHit.play()
				elif linear_velocity.length() > 250:
					$MedHit.play()
				elif linear_velocity.length() > 100:
					$SoftHit.play()
		allow_sound = 1
		end_c = linear_velocity.length()
