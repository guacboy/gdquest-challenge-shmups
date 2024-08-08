extends Node2D

@onready var enemy_spawn_location = $Enemy/EnemySpawn/EnemySpawnLocation
@onready var asteroid_spawn_location_left = $Asteroid/AsteroidSpawnLeft/AsteroidSpawnLocationLeft
@onready var asteroid_spawn_location_right = $Asteroid/AsteroidSpawnRight/AsteroidSpawnLocationRight

var asteroid_list := [
	preload("res://Common/Asteriods/small_asteriod.tscn"),
	preload("res://Common/Asteriods/big_asteriod.tscn"),
]

func _on_enemy_spawn_timer_timeout():
	var enemy_instance := preload("res://Characters/Enemy/enemy_basic.tscn").instantiate()
	enemy_spawn_location.progress_ratio = randf()
	enemy_instance.position = enemy_spawn_location.global_position
	add_child(enemy_instance)

func _on_asteroid_spawn_timer_left_timeout():
	var asteroid_instance = asteroid_list.pick_random().instantiate()
	asteroid_spawn_location_left.progress_ratio = randf()
	asteroid_instance.position = asteroid_spawn_location_left.global_position
	add_child(asteroid_instance)

func _on_asteroid_spawn_timer_right_timeout():
	var asteroid_instance = asteroid_list.pick_random().instantiate()
	asteroid_spawn_location_right.progress_ratio = randf()
	asteroid_instance.position = asteroid_spawn_location_right.global_position
	add_child(asteroid_instance)
