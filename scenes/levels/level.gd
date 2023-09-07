extends Node2D
class_name LevelParent

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var greanade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var flashstick_scene: PackedScene = preload("res://graphics/objects/flashstick.tscn")
var item_scene: PackedScene = preload("res://scenes/items/item.tscn")

func _ready():
	for container in get_tree().get_nodes_in_group('Container'):
		container.connect("open",  _on_container_opened)
	
	for scout in get_tree().get_nodes_in_group('Scouts'):
		scout.connect("laser_fired", _on_scout_laser_fired)
	
func _on_container_opened(pos, direction):
	var item = item_scene.instantiate()
	item.position = pos
	$Items.call_deferred('add_child',item)
	item.direction = direction
	
func _on_player_laser_fired(pos, direction):
	create_laser(pos, direction, 3000)

func _on_player_grenade_fired(pos, direction):
	var grenade = greanade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)
	
func _on_player_flashstick_fired(pos, direction):
	var flashstick = flashstick_scene.instantiate() as RigidBody2D
	flashstick.position = pos
	flashstick.linear_velocity = direction * flashstick.speed
	$Projectiles.add_child(flashstick)
	
func _on_scout_laser_fired(pos, direction):
	create_laser(pos, direction, 1000)

func create_laser(pos, direction, speed):
	var laser = laser_scene.instantiate() as Area2D
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.position = pos
	laser.direction = direction
	laser.speed = speed
	$Projectiles.add_child(laser)
	
func _on_player_update_stats():
	$UI.update_laser_text()
	$UI.update_grenade_text()
	$UI.update_flare_text()
