extends KinematicBody2D
class_name Enemy

const GRAVITY = 20
const SPEED  = 50
const UP = Vector2(0,-1)

var motion = Vector2()

var direction = 1


func _physics_process(delta):
	motion.y += GRAVITY 
	motion.x = SPEED * direction
	
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

func _on_StompArea2D_body_entered(body: Area2D) -> void:
	if body.is_in_group("Player"):
		if body.global_position.y > $StompArea2D.global_position.y:
			return
		die()


func die() -> void:
	queue_free()



