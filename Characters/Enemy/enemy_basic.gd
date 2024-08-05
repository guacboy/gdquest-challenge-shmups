extends CharacterBody2D

@onready var ship = $Ship

var new_position_x: int = position.x + 25
var new_position_y: int = position.y + 25

func _physics_process(delta) -> void:
	var tween := create_tween()
	tween.tween_property(ship, "position:x", new_position_x, 0.1).set_delay(1.0)
	tween.tween_property(ship, "position:y", new_position_y, 0.1).set_delay(1.0)
	tween.finished.connect(
		func() -> void:
			new_position_x = position.x + 25
			new_position_y = position.y + 25
	)
