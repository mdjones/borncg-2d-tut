extends KinematicBody2D

var velocity = Vector2()
export var direction = -1
export var detects_cliffs = true

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$floor_checker.enabled = detects_cliffs

func _physics_process(delta):
	if is_on_wall() or (not $floor_checker.is_colliding() and detects_cliffs and is_on_floor()):
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	velocity.y += 20
	velocity.x = direction*50
	
	## Have to add Vector2.UP so the enemy knows when it interacts with a wall
	velocity = move_and_slide(velocity, Vector2.UP)
