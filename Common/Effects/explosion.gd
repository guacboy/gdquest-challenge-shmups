extends AnimatedSprite2D

@onready var audio_stream_player_2d = $AudioStreamPlayer2D

var explosion_sound_list := [
	preload("res://Common/Effects/Sound Effects/8bit_expl_short_00.wav"),
	preload("res://Common/Effects/Sound Effects/8bit_expl_short_01.wav"),
	preload("res://Common/Effects/Sound Effects/8bit_expl_short_02.wav"),
	preload("res://Common/Effects/Sound Effects/8bit_expl_short_03.wav"),
	preload("res://Common/Effects/Sound Effects/8bit_expl_short_04.wav"),
	preload("res://Common/Effects/Sound Effects/8bit_expl_short_05.wav"),
]

func _process(delta) -> void:
	if !audio_stream_player_2d.is_playing():
		audio_stream_player_2d.stream = explosion_sound_list[randi_range(0, len(explosion_sound_list) - 1)]
		audio_stream_player_2d.play()

func _on_despawn_timer_timeout() -> void:
	queue_free()
