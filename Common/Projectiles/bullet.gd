extends Area2D

@onready var sprite_2d = $Sprite2D

func _physics_process(delta):
	sprite_2d.position.y -= 10

func _on_area_entered(area):
	if area.is_in_group("boundary"):
		print("delete")
