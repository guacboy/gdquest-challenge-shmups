extends CharacterBody2D

@onready var marker_2d = $Marker2D
@onready var shoot_timer = $ShootTimer

func _ready() -> void:
	shoot_timer.wait_time = randf_range(1.0, 2.0)
	shoot_timer.start()

func _physics_process(delta) -> void:
	position.y += 1

func _on_area_2d_area_entered(area):
	if area.is_in_group("bullet"):
		queue_free()

func _on_shoot_timer_timeout():
	var bullet_instance := preload("res://Common/Projectiles/enemy_bullet.tscn").instantiate()
	bullet_instance.position = marker_2d.get_global_position()
	get_parent().add_child(bullet_instance)
	
	shoot_timer.wait_time = randf_range(1.0, 2.0)
	shoot_timer.start()
