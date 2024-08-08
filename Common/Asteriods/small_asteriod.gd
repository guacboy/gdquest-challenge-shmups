extends Sprite2D

var random_rotation_speed := randf_range(20.0, 30.0)
var random_rotation_direction := randi_range(-10, 10)
var random_movement_speed := randi_range(1, 10)
var random_direction_x := randf_range(-0.1, 0.1)

func _ready() -> void:
	scale = Vector2.ONE * randf_range(1.0, 2.5)

func _physics_process(delta) -> void:
	position.y += random_movement_speed
	position.x += random_direction_x
	
	var tween := create_tween()
	tween.tween_property(self, "rotation", random_rotation_direction, random_rotation_speed)

func _on_area_2d_area_entered(area):
	if area.is_in_group("death zone"):
		queue_free()
