extends CharacterBody2D

@export var SPEED : int = 100
@export var JUMP_FORCE : int = 175
@export var GRAVITY : int = 750
const DASH_SPEED = 350
var dashing = false
var can_dash = true
const SPRINT_SPEED = 185
var sprinting = false
var health = 100
var enemy_inattack_range = false
var enemy_attack_cooldown = true
var player_alive = true
var attack_ip = false
var current_dir = "none"

func _physics_process(delta):
	enemy_attack()
	attack()
	
	
	
	if health <= 0:
		player_alive = false #go back to menu or respond
		health = 0
		print("player has been killed")
		on_player_death()
		
		
	
	var direction = Input.get_axis("Left", "Right")#getting input for w and d
	

	if Input.is_action_just_pressed("dash") and can_dash:
		dashing = true #initiating dash
		can_dash = false
		$dash_timer.start() #cooldown start
		$dash_again_timer.start()

	if Input.is_action_pressed("sprint"):
		sprinting = true
	else:
		sprinting = false


	
	if direction:
		handle_movement(direction)
	else:
		handle_idle()

	handle_flip(direction)#flipping sprite

	handle_gravity(delta)

	handle_jump()

	move_and_slide()
	
	update_health()



func handle_movement(direction):
	current_dir = direction#finding player facing
	if sprinting:
		velocity.x = direction * SPRINT_SPEED
	elif dashing:
		velocity.x = direction * DASH_SPEED
	else:
		velocity.x = SPEED * direction
		if is_on_floor():#animation player for run
			if attack_ip == false:
				$AnimatedSprite2D.play("run")

func handle_idle():
	velocity.x = 0
	if is_on_floor():#animation player for idle
		if attack_ip == false:
			$AnimatedSprite2D.play("idle")

func handle_flip(direction):
	if direction == 1:#flipping character sprite according to direction on x axis
		if attack_ip == false:
			$AnimatedSprite2D.flip_h = false
	elif direction == -1:
		if attack_ip == false:
			$AnimatedSprite2D.flip_h = true

func handle_gravity(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		if velocity.y > 0:
			if attack_ip == false:
				$AnimatedSprite2D.play("Fall")

func handle_jump():
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y -= JUMP_FORCE
		if attack_ip == false:
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
		enemy_inattack_range = false
		
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)


func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
	
func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_ip = true
			


func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack = false
	attack_ip = false



func on_player_death():
	print("player dead")
	get_tree().change_scene_to_file("res://Scenes/death_screen.tscn")
