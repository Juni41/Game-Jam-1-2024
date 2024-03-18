extends CharacterBody2D

@export var SPEED : int = 100
@export var JUMP_FORCE : int = 175
@export var GRAVITY : int = 750
const DASH_SPEED = 800
var dashing = false
var can_dash = true
const SPRINT_SPEED = 200
var sprinting = false


func _physics_process(delta):
	var direction = Input.get_axis("Left", "Right")

	if Input.is_action_just_pressed("dash") and can_dash:
		dashing = true
		can_dash = false
		$dash_timer.start()
		$dash_again_timer.start()

	if Input.is_action_pressed("sprint"):
		sprinting = true
	else:
		sprinting = false


	
	if direction:
		handle_movement(direction)
	else:
		handle_idle()

	handle_flip(direction)

	handle_gravity(delta)

	handle_jump()

	move_and_slide()



func handle_movement(direction):
	if sprinting:
		velocity.x = direction * SPRINT_SPEED
	elif dashing:
		velocity.x = direction * DASH_SPEED
	else:
		velocity.x = SPEED * direction
		if is_on_floor():
			$AnimatedSprite2D.play("run")

func handle_idle():
	velocity.x = 0
	if is_on_floor():
		$AnimatedSprite2D.play("idle")

func handle_flip(direction):
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
	elif direction == -1:
		$AnimatedSprite2D.flip_h = true

func handle_gravity(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		if velocity.y > 0:
			$AnimatedSprite2D.play("Fall")

func handle_jump():
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y -= JUMP_FORCE
		$AnimatedSprite2D.play("jump")

func _on_dash_timer_timeout() -> void:
	dashing = false

func _on_dash_again_timer_timeout() -> void:
	can_dash = true
