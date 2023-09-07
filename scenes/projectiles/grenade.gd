extends RigidBody2D

var speed = 1500
var can_damage: bool = false
var blast_zone = 800
func explode():
	$AnimationPlayer.play("Explosion")
	can_damage=true

func _process(_delta):
	if can_damage:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < blast_zone
			if "hit" in target and in_range:
				target.hit()
