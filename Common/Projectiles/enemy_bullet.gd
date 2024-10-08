extends Area2D

@onready var audio_stream_player_2d = $AudioStreamPlayer2D

var bullet_sound_list := [
	preload("res://Common/Projectiles/Sound Effects/bullet_sound_effect_1.mp3"),
	preload("res://Common/Projectiles/Sound Effects/bullet_sound_effect_2.mp3"),
	preload("res://Common/Projectiles/Sound Effects/bullet_sound_effect_3.mp3"),
]

func _ready() -> void:
	audio_stream_player_2d.stream = bullet_sound_list.pick_random()
	audio_stream_player_2d.play()

# bullet speed
func _physics_process(delta):
	position.y += 10
	
func _on_area_entered(area):
	if area.is_in_group("player"):
		queue_free()
