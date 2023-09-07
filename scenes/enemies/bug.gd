extends CharacterBody2D

var active: bool = false
var speed: int = 300
var i_frames:bool = false
var player_near: bool = false
var health: int=20

func _process(_delta):
	var direction = (Globals.player_pos - position).normalized()
	velocity=direction * speed
	if active:
		look_at(Globals.player_pos)
		move_and_slide()

func _on_attack_area_body_entered(_body):
	$AnimatedSprite2D.play("attack")
	player_near = true


func _on_attack_area_body_exited(_body):
	$AnimatedSprite2D.play("walk")
	player_near = false


func _on_notice_area_body_entered(_body):
	$AnimatedSprite2D.play("walk")
	active = true


func _on_notice_area_body_exited(_body):
	$AnimatedSprite2D.stop()
	active = false


func _on_animated_sprite_2d_animation_finished():
	if player_near:
		Globals.health -= 5
	$Timers/AttackTimer.start()

func _on_attack_timer_timeout():
	$AnimatedSprite2D.play("attack") # Replace with function body.

func hit():
	if not i_frames:
		health-=10
		i_frames = true
		$Timers/IFrames.start()
		$AnimationPlayer.play("i_frames")
		if health <= 0:
			queue_free()


func _on_i_frames_timeout():
	i_frames = false
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.stop()
