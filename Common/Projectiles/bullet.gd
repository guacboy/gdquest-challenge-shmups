extends Area2D

@onready var collision_shape_2d = $CollisionShape2D

func _physics_process(delta):
	position.y -= 20
	
func _on_area_entered(area):
	if area.is_in_group("enemy"):
		queue_free()
	
func _on_delete_self_timer_timeout():
	queue_free()
