extends KinematicBody2D

const ACCELERATION = 50
const UP = Vector2(0,-1)
const GRAVITY = 20
const MAX_SPEED = 200
const JUMP_HEIGHT = -550

var motion = Vector2()
var direction = 1


func die():
	$DeathTimer.start()
	$Sprite.play("death")
	set_physics_process(false)
	


func _on_DeathTimer_timeout():
	get_tree().reload_current_scene()

func _on_EnemyDetector_body_entered(body: Node2D):
	var bodies = $EnemyDetector.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Enemy"):
			die()
		else: 
			pass 
 
# Bounce when landing on enemy
func _on_StompDetector_area_entered(area: Node2D):
	if area.is_in_group("Enemy"):
		motion.y = JUMP_HEIGHT


#Controls/Movement/Abilities
func _physics_process(_delta):
	
	# Gravity
	motion.y += GRAVITY
	#Controls
	var left_button_pressed = Input.is_action_pressed("ui_left")
	var right_button_pressed = Input.is_action_pressed("ui_right")
	var up_button_pressed = Input.is_action_pressed("ui_up")
	# Movement for Controls
	if right_button_pressed:
		$Sprite.flip_h = false
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		
	elif left_button_pressed:
		$Sprite.flip_h = true
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		
	else: # Set motion to 0 if standing still
		motion.x = 0
	# Jump 
	if is_on_floor():
		if up_button_pressed:
			motion.y = JUMP_HEIGHT
	# Wall Jump
	if is_on_wall():
		print("gae")
		if Input.is_action_just_pressed("ui_up"):
			
			if $RightWallDetect.is_colliding():
				motion.y = -550
				motion.x = -550
			if $LeftWallDectect.is_colliding():
				motion.y = -550
				motion.x = 550
	motion = move_and_slide(motion, UP)





