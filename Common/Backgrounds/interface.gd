extends Control

@onready var highscore = $StatsBox/HighscoreBox/Highscore

var current_score: int = 0

func _ready() -> void:
	Signals.connect("on_score_increment", _on_score_increment)
	
func _on_score_increment(amount) -> void:
	current_score += amount
	
	# allows for the zero placeholders on the left
	var zero_placeholder: String = ""
	if current_score >= 100000:
		pass
	elif current_score >= 10000:
		zero_placeholder = "0"
	elif current_score >= 1000:
		zero_placeholder = "00"
	elif current_score >= 100:
		zero_placeholder = "000"
	elif current_score >= 10:
		zero_placeholder = "0000"
	
	# if player reaches max score, the score will cap
	if current_score >= 999999:
		current_score = 999999

	highscore.text = "[center]" + zero_placeholder + str(current_score) + "[/center]"
