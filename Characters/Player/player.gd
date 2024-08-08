extends CharacterBody2D

@onready var marker_2d = $Marker2D
@onready var bullet_delay_timer = $BulletDelayTimer

const SPEED: float = 600.0

func _physics_process(delta) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED
	move_and_slide()
	
	# adds a delay between each bullet; prevents machine gunning
	if (Input.is_action_pressed("shoot")
	and bullet_delay_timer.is_stopped()):
		shoot()

func shoot() -> void:
	var bullet_instance := preload("res://Common/Projectiles/bullet.tscn").instantiate()
	bullet_instance.position = marker_2d.get_global_position()
	get_parent().add_child(bullet_instance)
	bullet_delay_timer.start()

func _on_area_2d_area_entered(area):
	if (area.is_in_group("enemy bullet")
	or area.is_in_group("enemy")
	or area.is_in_group("asteroid")):
		var explosion := preload("res://Common/Effects/explosion.tscn").instantiate()
		explosion.global_position = global_position
		explosion.rotation = randi_range(0, 360) # randomizes explosion
		get_parent().add_child(explosion)
		queue_free()
