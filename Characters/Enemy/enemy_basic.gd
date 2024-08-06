extends CharacterBody2D

func _physics_process(delta) -> void:
	pass

func _on_area_2d_area_entered(area):
	print("passed")
	if area.is_in_group("bullet"):
		queue_free()
