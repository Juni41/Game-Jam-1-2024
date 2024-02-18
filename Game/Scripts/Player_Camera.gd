extends Camera2D

var player
var speed = 200  # Adjust this value based on your game's needs

func _process(delta):
	if player:
		var target_position = player.global_position
		position += (target_position - position) * speed * delta
