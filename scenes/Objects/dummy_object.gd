extends StaticBody2D
class_name DummyObject

@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)
var opened: bool = false
@export var amt: int
signal open(pos, direction)

func hit():
	if not opened:
		$Lid.hide()
		for i in range(amt):
			var pos = $SpawnPosition.get_child(randi()%$SpawnPosition.get_child_count()).global_position
			open.emit(pos, current_direction)
		opened = true
