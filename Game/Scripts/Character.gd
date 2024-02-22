extends CharacterBody2D
 
@export var SPEED : int = 100
@export var JUMP_FORCE : int = 175
@export var GRAVITY : int = 750
@export var MAX_HEALTH : int = 100
@onready var  CURRENT_HEALTH: int = MAX_HEALTH


func _physics_process(delta):
	var direction = Input.get_axis("Left","Right")
	if direction:
		velocity.x = SPEED * direction
		if is_on_floor():
			$AnimatedSprite2D.play("run")
	else:
		velocity.x = 0
		if is_on_floor():
			$AnimatedSprite2D.play("idle")
	
	# flips character
	
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
	elif direction == -1:
		$AnimatedSprite2D.flip_h = true
	handleCollision()
	
	# Gravity
	
	if not is_on_floor():
		
		velocity.y += GRAVITY * delta
		
		if velocity.y > 0:
			
			$AnimatedSprite2D.play("Fall")
	
	# Jump
	
	if is_on_floor():
		
		if Input.is_action_just_pressed("jump"):
			
			velocity.y -= JUMP_FORCE
			$AnimatedSprite2D.play("jump")
	
	
	move_and_slide()
func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print_debug()
func _on_hurt_box_area_entered(area):
	if area.name == "hitBox":
		CURRENT_HEALTH -= 1
		print_debug()
		

