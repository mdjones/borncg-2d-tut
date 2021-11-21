extends KinematicBody2D

var velocity = Vector2(0,0)

const SPEED = 180
const GRAVITY = 50
const JUMP_FORCE = -2300

func _physics_process(delta):
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = true
	else:
		$Sprite.play("idle")
		
	if not is_on_floor():
		$Sprite.play("air")
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_FORCE
		if position.y > 700:
			position = Vector2(280,0)

	velocity.y = velocity.y + GRAVITY

	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x, 0, 0.05)
	velocity.y = lerp(velocity.y, 0, 0.05)