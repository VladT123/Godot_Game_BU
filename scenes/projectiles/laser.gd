extends Area2D

@export var speed: int
var direction: Vector2

func _ready():
	$Timer.start()

func _process(delta):
	position += direction*speed*delta

func explode():
	speed=0
	$AnimationPlayer.play('Explosion')


func _on_body_entered(body):
	if 'hit' in body:
		body.hit()
	explode()

func _on_timer_timeout():
	explode()
