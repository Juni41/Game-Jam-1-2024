extends Control


func _on_play_pressed():#hide menu and initiate game
	get_tree().change_scene_to_file("res://main.tscn")


func _on_options_pressed():#switch scenes to option menu
	get_tree().change_scene_to_file("res://Magik/options_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()#close window/end task
