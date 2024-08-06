extends Area2D

@onready var sprite_2d = $Sprite2D

func _physics_process(delta):
	sprite_2d.position.y -= 5
	
func _on_delete_self_timer_timeout():
	queue_free()
