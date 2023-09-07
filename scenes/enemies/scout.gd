extends CharacterBody2D

signal laser_fired(pos, direction)

var player_nearby: bool = false
var can_laser: bool = true
var pistol: bool = false
var health: int = 40 
var speed: int = 300
var i_frames: bool = false

func _process(_delta):
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			var direction: Vector2 = (Globals.player_pos-position).normalized()
			var laser_markers = $LaserSpawnPositions.get_children()
			var selected_laser = laser_markers[int(pistol)]
			var pos: Vector2 = selected_laser.global_position
			laser_fired.emit(pos,direction)
			can_laser = false
			pistol = not pistol
			$Timers/LaserCooldown.start()

func hit():
	if not i_frames:
		health-=10
		i_frames = true
		$Timers/IFrames.start()
		$AnimationPlayer.play("i_frames")
		if health <= 0:
			queue_free()
			

func _on_attack_area_body_entered(_body):
	player_nearby = true

func _on_attack_area_body_exited(_body):
	player_nearby = false

func _on_laser_cooldown_timeout():
	can_laser=true


func _on_i_frames_timeout():
	i_frames = false
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.stop()
