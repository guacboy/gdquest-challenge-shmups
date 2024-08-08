extends CharacterBody2D

@onready var ship = $Ship
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var marker_2d = $Marker2D
@onready var bullet_delay_timer = $BulletDelayTimer
@onready var respawn_timer = $RespawnTimer
@onready var invincibility_timer = $InvincibilityTimer

@onready var game_start_overlay = $"../GameStartOverlay"
@onready var game_over_display_timer = $"../GameOverOverlay/GameOverDisplayTimer"

const SPEED: float = 600.0
var player_control: bool = true
var extra_life: int = 3

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
		var explosion_instance := preload("res://Common/Effects/explosion.tscn").instantiate()
		explosion_instance.global_position = global_position
		explosion_instance.rotation = randi_range(0, 360) # randomizes explosion
		get_parent().add_child(explosion_instance)
		
		extra_life -= 1
		# disables shooting and "respawns" ship with invincibility frames
		ship.visible = false
		collision_shape_2d.set_deferred("disabled", true)
		player_control = false
		
		if extra_life >= 0:
			respawn_timer.start()
		else:
			if game_start_overlay.visible == true:
				game_start_overlay.visible = false
			game_over_display_timer.start() # adds a delay before Game Over screen
			queue_free()

func _on_respawn_timer_timeout():
	player_control = true
	
	# takes away a life sprite
	Signals.emit_signal("on_life_decrement")
	
	# fades sprite in-n-out, similar to invincibility frames
	var tween := create_tween()
	tween.tween_property(ship, "visible", false, 0.1)
	tween.tween_property(ship, "visible", true, 0.1)
	tween.set_loops(10)
	
	invincibility_timer.start()

func _on_invincibility_timer_timeout():
	collision_shape_2d.set_deferred("disabled", false)
