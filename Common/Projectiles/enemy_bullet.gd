extends Area2D

# bullet speed
func _physics_process(delta):
	position.y += 10
	
func _on_area_entered(area):
	if area.is_in_group("player"):
		queue_free()
	
func _on_delete_self_timer_timeout():
	queue_free()
