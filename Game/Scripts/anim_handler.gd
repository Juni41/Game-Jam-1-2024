extends Node2D

@onready var anim = $AnimatedSprite2D2 #Grass animation
@onready var anim2 = $AnimatedSprite2D #Flower animation
@onready var anim3 = $AnimatedSprite2D3 #wide grass animation
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Grass")
	anim2.play("Flower")
	anim3.play("wide grass")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
