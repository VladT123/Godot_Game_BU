extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Vector2(1,0)
	velocity=direction*100
	move_and_slide()

func hit():
	print('ouch')
