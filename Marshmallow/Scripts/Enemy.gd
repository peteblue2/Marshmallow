extends KinematicBody2D
class_name Enemy

const GRAVITY = 20
const SPEED  = 50
const UP = Vector2(0,-1)

var motion = Vector2()
var direction = 1

func die():
	queue_free()

func _physics_process(delta):
	#Gravity
	motion.y += GRAVITY 
	# Motion.x = Speed x 1 (or -1 if the direction is the other way)
	motion.x = SPEED * direction
	# Movement
	motion = move_and_slide(motion, UP)
	if direction == 1:
		$Sprite.flip_h = false
	else:
		 $Sprite.flip_h = true
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1

func _on_StompArea2D_area_entered(area: Node2D):
		if area.is_in_group("Player"):
			die()









