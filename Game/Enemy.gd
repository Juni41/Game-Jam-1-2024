extends CharacterBody2D

@export var speed = 200
var player_chase = false
var player = null
var health = 100

func _physics_process(delta):
	if player_chase and player:
		var direction = (player.global_position - self.global_position).normalized()
		position += direction * speed * delta
		print (direction)
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
