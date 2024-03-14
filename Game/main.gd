extends Node2D

@onready var pause_menu = $PauseMenu
var paused = false
update_dirty_quadrants()
# Called when the node enters the scene tree for the first time.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused
