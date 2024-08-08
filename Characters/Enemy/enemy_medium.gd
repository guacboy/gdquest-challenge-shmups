extends CharacterBody2D

@onready var ship = $Ship
@onready var marker_2d = $Marker2D
@onready var health_bar = $HealthBar
@onready var shoot_timer = $ShootTimer
@onready var double_shoot_timer = $DoubleShootTimer

func _ready() -> void:
	shoot_timer.wait_time = randf_range(1.0, 2.0)
	double_shoot_timer.wait_time = shoot_timer.wait_time + 0.1
	shoot_timer.start()
	double_shoot_timer.start()

# movement
func _physics_process(delta) -> void:
	position.y += 0.5

func shoot() -> void:
	var bullet_instance := preload("res://Common/Projectiles/enemy_bullet.tscn").instantiate()
	bullet_instance.position = marker_2d.get_global_position()
	get_parent().add_child(bullet_instance)

func take_damage() -> void:
	health_bar.visible = true
	health_bar.value -= 1
	
	if health_bar.value <= 0:
		explode_on_death()

# plays explosion after death
func explode_on_death() -> void:
	var explosion := preload("res://Common/Effects/explosion.tscn").instantiate()
	explosion.global_position = global_position
	explosion.rotation = randi_range(0, 360) # randomizes explosion
	get_parent().add_child(explosion)
	queue_free()

func _on_area_2d_area_entered(area):
	if area.is_in_group("bullet"):
		take_damage()
	if (area.is_in_group("player")):
		explode_on_death()
	if area.is_in_group("death zone"):
		queue_free()

func _on_shoot_timer_timeout():
	shoot()
	
	shoot_timer.wait_time = randf_range(1.0, 2.0)
	shoot_timer.start()

# allows for rapid succession shots
func _on_double_shoot_timer_timeout():
	shoot()
	
	double_shoot_timer.wait_time = shoot_timer.wait_time
	double_shoot_timer.start()
