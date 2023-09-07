extends Node

signal stat_change


var laser_max = 99
var grenade_max = 5
var flare_max = 4
var health_max = 100

var laser_amount = 99: 
	set(value):
		laser_amount = value
		stat_change.emit()

var grenade_amount = 5: 
	set(value):
		grenade_amount = value
		stat_change.emit()

var flare_amount = 4: 
	set(value):
		flare_amount = value
		stat_change.emit()

var player_i_frames: bool = false

var health = 100: 
	set(value):
		if value>health:
			health = value
		else:
			if not player_i_frames:
				health = value
				player_i_frames = true
				player_i_frame_timer()
		stat_change.emit()

func player_i_frame_timer():
	await get_tree().create_timer(0.5).timeout
	player_i_frames = false

var player_pos: Vector2
