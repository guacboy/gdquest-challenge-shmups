extends Node2D

@onready var enemy_spawn_location = $Enemy/EnemySpawn/EnemySpawnLocation
@onready var asteroid_spawn_location_left = $Asteroid/AsteroidSpawnLeft/AsteroidSpawnLocationLeft
@onready var asteroid_spawn_location_right = $Asteroid/AsteroidSpawnRight/AsteroidSpawnLocationRight
@onready var enemy_spawn_timer = $Enemy/EnemySpawnTimer

@onready var game_start_overlay = $GameStartOverlay

@onready var game_over = $GameOverOverlay/VBoxContainer/GameOver
@onready var retry_button = $GameOverOverlay/VBoxContainer/RetryButton
@onready var quit_button = $GameOverOverlay/VBoxContainer/QuitButton

var enemy_list := [
	preload("res://Characters/Enemy/enemy_basic.tscn"),
	preload("res://Characters/Enemy/enemy_medium.tscn"),
	preload("res://Characters/Enemy/enemy_hard.tscn"),
]

var asteroid_list := [
	preload("res://Common/Asteriods/small_asteriod.tscn"),
	preload("res://Common/Asteriods/big_asteriod.tscn"),
]

# spawn mechanic
func _on_enemy_spawn_timer_timeout():
	var enemy_instance = enemy_list.pick_random().instantiate()
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

# start menu
func _on_start_button_pressed():
	game_start_overlay.visible = false
	enemy_spawn_timer.start()

func _on_quit_button_pressed():
	get_tree().quit()

# game over menu
func _on_game_over_display_timer_timeout():
	var tween := create_tween()
	tween.tween_property(game_over, "visible_ratio", 0.5, 0.5)
	tween.tween_property(game_over, "visible_ratio", 1.0, 0.5).set_delay(0.5)
	tween.tween_property(retry_button, "modulate:a", 1.0, 0.1).set_delay(0.5)
	retry_button.disabled = false
	tween.tween_property(quit_button, "modulate:a", 1.0, 0.1)
	quit_button.disabled = false

func _on_retry_button_pressed():
	get_tree().reload_current_scene()

func _on_quit_button_presed():
	get_tree().quit()
