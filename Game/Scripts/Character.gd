extends CharacterBody2D

@export var SPEED : int = 100
@export var JUMP_FORCE : int = 175
@export var GRAVITY : int = 750
const DASH_SPEED = 800
var dashing = false
var can_dash = true
const SPRINT_SPEED = 200
var sprinting = false
var health = 100
var enemy_inattack_range = false
var enemy_attack_cooldown = true
var player_alive = true
var attack_ip = false

func _physics_process(delta):
	enemy_attack()
	
	if health <= 0:
		player_alive = false #go back to menu or respond
		health = 0
		print("player has been killed")
		self.queue_free()
	
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
	
	update_health()



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



func update_health():
	var healthbar = $healthbar

	
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true


func _on_regen_timer_timeout():
	if health < 100:
		health = health + 20
		if health > 100:
			health = 100
	if health <= 0:
		health = 0

func player():
	pass


func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true
		
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)


func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
