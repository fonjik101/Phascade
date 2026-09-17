extends Control


func _ready() -> void:
	GlobalVars.read_save()
	$ScoreLabel.text = str("Score: ", GlobalVars.score)
	$HighScoreLabel.text = str("High Score: ", GlobalVars.high_score)

func _on_start_label_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Main.tscn")


func _on_quit_label_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")
