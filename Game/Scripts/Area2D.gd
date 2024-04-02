extends Area2D

var label : Label

func _ready():
	label = get_node("Label")



func _on_body_entered(body):
	if body.is_in_group("Player"):
		label.text = "Press E to dash!"




func _on_body_exited(body):
	if body.is_in_group("Player"):
		label.text = ""
