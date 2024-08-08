extends CharacterBody2D

@onready var marker_2d = $Marker2D
@onready var shoot_timer = $ShootTimer
@onready var ship = $Ship

func _ready() -> void:
	shoot_timer.wait_time = randf_range(1.0, 2.0)
	shoot_timer.start()

# movement
func _physics_process(delta) -> void:
	position.y += 1

func _on_area_2d_area_entered(area):
	if (area.is_in_group("bullet")
	or area.is_in_group("player")):
		# explosion on death
		var explosion_instance := preload("res://Common/Effects/explosion.tscn").instantiate()
		explosion_instance.global_position = global_position
		explosion_instance.rotation = randi_range(0, 360) # randomizes explosion
		get_parent().add_child(explosion_instance)
		
		# add to highscore
		Signals.emit_signal("on_score_increment", 20)
		
		queue_free()
		
	if area.is_in_group("death zone"):
		queue_free()

func _on_shoot_timer_timeout():
	var bullet_instance := preload("res://Common/Projectiles/enemy_bullet.tscn").instantiate()
	bullet_instance.position = marker_2d.get_global_position()
	get_parent().add_child(bullet_instance)
	
	shoot_timer.wait_time = randf_range(1.0, 2.0)
	shoot_timer.start()
