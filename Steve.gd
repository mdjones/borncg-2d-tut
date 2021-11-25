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

	velocity.y = velocity.y + GRAVITY

	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x, 0, 0.05)
	velocity.y = lerp(velocity.y, 0, 0.05)


func _on_FallZone_body_entered(body):
	get_tree().change_scene("res://Level1.tscn")


func bounce():
	velocity.y = JUMP_FORCE*0.6
	
func ouch(var enemy_pos_x):
	set_modulate(Color(1,0.3,0.3,0.4))
	velocity.y = JUMP_FORCE*0.5
	if position.x < enemy_pos_x:
		velocity.x = -800
	elif position.x > enemy_pos_x:
		velocity.x = 800
	Input.action_release("left")
	Input.action_release("right")
	
	$Timer.start()


func _on_Timer_timeout():
	get_tree().change_scene("res://Level1.tscn")
