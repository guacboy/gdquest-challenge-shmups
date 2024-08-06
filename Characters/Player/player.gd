extends CharacterBody2D

@onready var marker_2d = $Marker2D
@onready var bullet_delay_timer = $BulletDelayTimer

const SPEED: float = 600.0

func _physics_process(delta) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED
	move_and_slide()
	
	if (Input.is_action_pressed("shoot")
	and bullet_delay_timer.is_stopped()):
		shoot()

func shoot() -> void:
	var bullet_instance := preload("res://Common/Projectiles/bullet.tscn").instantiate()
	bullet_instance.position = marker_2d.get_global_position()
	get_parent().add_child(bullet_instance)
	bullet_delay_timer.start()
