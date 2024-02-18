# AreaTrigger.gd

extends Area2D

@onready var popup_scene = preload("res://popup.tscn")

func _on_Area2D_area_entered(area):
	var popup_instance = popup_scene.instance()
	popup_instance.set_popup_text("Surface")
	add_child(popup_instance)
