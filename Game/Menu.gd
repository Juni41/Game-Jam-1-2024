extends Control


func _on_play_pressed():
	get_tree().change_scene_to_file("res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Magik/options_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()
