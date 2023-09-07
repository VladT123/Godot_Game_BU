extends CharacterBody2D

signal laser_fired(pos, direction)
signal grenade_fired(pos, direction)
signal flashstick_fired(pos, direction)

var can_laser:bool = true
var can_grenade:bool = true
var can_flashstick:bool = true

@export var max_speed: int = 900
var speed: int = max_speed

func _process(_delta):
	
	var direction = Input.get_vector("left", "right", "up","down")
	velocity=direction*speed
	move_and_slide()
	Globals.player_pos = global_position
	look_at(get_global_mouse_position())
	
	var player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		can_laser = false
		$Timers/Timer_Laser.start()
		$GPUParticles2D.emitting=true
		$GunFlash.enabled=true
		var laser_markers = $Laser_start_pos.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		laser_fired.emit(selected_laser.global_position, player_direction)
		
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		can_grenade = false
		$Timers/Timer_Grenade.start()
		var laser_markers = $Laser_start_pos.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		grenade_fired.emit(selected_laser.global_position, player_direction)
	
	if Input.is_action_pressed("FlashStick") and can_flashstick and Globals.flare_amount > 0:
		Globals.flare_amount -= 1
		can_flashstick = false
		$Timers/Timer_Flashstick.start()
		var laser_markers = $Laser_start_pos.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		flashstick_fired.emit(selected_laser.global_position, player_direction)
	
	if Input.is_action_just_pressed("flashlight"):
		if $Flashlight.enabled == true:
			$Flashlight.enabled = false
		else:
			$Flashlight.enabled = true
	
	if Globals.player_i_frames:
		$AnimationPlayer.play("i_frames")
		
func _on_timer_laser_timeout():
	can_laser = true
	$GunFlash.enabled=false

func _on_timer_grenade_timeout():
	can_grenade = true

func _on_timer_flashstick_timeout():
	can_flashstick = true
	
func i_frame_reset():
	$AnimationPlayer.play("RESET")
func hit():
	Globals.health-=10



