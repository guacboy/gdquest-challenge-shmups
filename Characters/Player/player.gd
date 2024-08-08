extends CharacterBody2D

@onready var ship = $Ship
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var marker_2d = $Marker2D
@onready var bullet_delay_timer = $BulletDelayTimer
@onready var respawn_timer = $RespawnTimer
@onready var invincibility_timer = $InvincibilityTimer

const SPEED: float = 600.0
var player_control: bool = true

func _physics_process(delta) -> void:
	if player_control:
		# movement
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
		# explosion on death
		var explosion := preload("res://Common/Effects/explosion.tscn").instantiate()
		explosion.global_position = global_position
		explosion.rotation = randi_range(0, 360) # randomizes explosion
		get_parent().add_child(explosion)
		
		# disables shooting and "respawns" ship with invincibility frames
		player_control = false
		ship.visible = false
		collision_shape_2d.set_deferred("disabled", true)

		respawn_timer.start()

func _on_respawn_timer_timeout():
	player_control = true
	
	# fades sprite in-n-out, similar to invincibility frames
	var tween := create_tween()
	tween.tween_property(ship, "visible", false, 0.1)
	tween.tween_property(ship, "visible", true, 0.1)
	tween.set_loops(10)
	
	invincibility_timer.start()

func _on_invincibility_timer_timeout():
	collision_shape_2d.set_deferred("disabled", false)
