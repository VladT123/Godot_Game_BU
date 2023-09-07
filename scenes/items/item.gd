extends Area2D

var rotation_speed: int = 4
var available_options = ['laser', 'laser', 'laser', 'laser', 'grenade', 'flare', 'health',]
var type = available_options[randi()%len(available_options)]

var direction: Vector2
var distance: int = randi_range(150,250)

func _ready():
	if type == 'laser':
		print(type)
		$Orb.modulate=Color('0000e4')
		$PointLight2D.color=Color('0000e4')
	elif type == 'grenade': 
		print(type)
		$Orb.modulate=Color('ef0000')
		$PointLight2D.color=Color('ef0000')
		print(type)
	elif type == 'health': 
		print(type)
		$Orb.modulate=Color('00ff00')
		$PointLight2D.color=Color('00ff00') 
	else : 
		print(type)
		$Orb.modulate=Color('00ffe4')
		$PointLight2D.color=Color('00ffe4') 
	
	
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self,'position', target_pos, 0.5)
	tween.tween_property(self,'scale', Vector2(1,1), 0.3).from(Vector2(0,0))


func _process(delta):
	rotation+=rotation_speed*delta


func get_item(amount, current, maximum):
	current += amount
	if current > maximum:
		current = maximum
	queue_free()
	return current	


func _on_body_entered(_body):
	if type == 'laser' and Globals.laser_amount < Globals.laser_max:
		Globals.laser_amount = get_item(5, Globals.laser_amount, Globals.laser_max)
	
	if type == 'grenade' and Globals.grenade_amount < Globals.grenade_max:
		Globals.grenade_amount = get_item(1, Globals.grenade_amount, Globals.grenade_max)
		
	if type == 'flare' and Globals.flare_amount < Globals.flare_max:
		Globals.flare_amount = get_item(1, Globals.flare_amount, Globals.flare_max)
		
	if type == 'health' and Globals.health < Globals.health_max:
		Globals.health = get_item(10, Globals.health,Globals.health_max)


