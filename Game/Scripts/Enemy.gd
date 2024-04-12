extends CharacterBody2D

@export var speed = 200
var player_chase = false
var player = null
var health = 50
var player_inattack_zone = false
var can_take_damage = true

func _physics_process(delta):

	deal_with_damage()
	
	if player_chase and player:
		var direction = (player.global_position - self.global_position).normalized()
		position += direction * speed * delta
	update_health()
func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		player = body
		player_chase = true

func _on_detection_area_body_exited(body):
	if body == player:
		player = null
		player_chase = false


func update_health():
	var healthbar = $healthbar
	
	healthbar.value = health

	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true

func enemy():
	pass


func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true
		$AnimatedSprite2D.play("default")


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false
		
func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print("crab health = ", health)
			if health <= 0:
				self.queue_free()
				get_tree().change_scene_to_file("res://Scenes/win_screen.tscn")


func _on_take_damage_cooldown_timeout():
	can_take_damage = true
