extends CharacterBody2D

@onready var ship = $Ship

const SPEED: float = 600.0

func _physics_process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED
	move_and_slide()
	
	if Input.is_action_pressed("shoot"):
		var bullet_instance := preload("res://Common/Projectiles/bullet.tscn").instantiate()
		bullet_instance.position = ship.position
		add_child(bullet_instance)
