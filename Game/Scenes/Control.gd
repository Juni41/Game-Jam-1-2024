extends Control

func _on_main_menu_pressed():#switch scenes to option menu
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
