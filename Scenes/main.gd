extends Node2D

@onready var path_follow_2d = $EnemySpawn/PathFollow2D

func _on_spawn_timer_timeout():
	var enemy_instance := preload("res://Characters/Enemy/enemy_basic.tscn").instantiate()
	path_follow_2d.progress_ratio = randf()
	enemy_instance.position = path_follow_2d.global_position
	add_child(enemy_instance)
