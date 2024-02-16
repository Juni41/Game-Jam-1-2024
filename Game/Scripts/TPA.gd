extends Area2D

var destination_teleporter: Node2D # Reference to the destination teleporter

func _on_TeleporterA_body_entered(body):
	if body.is_in_group("player"): # Change "player" to your player's group
		body.position = destination_teleporter.position
