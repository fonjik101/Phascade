extends Control

@onready var start_label: Button = $StartLabel
@onready var quit_label: Button = $QuitLabel

func _ready() -> void:
	Music.lost = true
	Music.is_danger = false
	Music.is_hunting = true
	GlobalVars.read_save()
	$ScoreLabel.text = str("Score: ", GlobalVars.score)
	$HighScoreLabel.text = str("High Score: ", GlobalVars.high_score)

func _physics_process(delta: float) -> void:
	if start_label.is_hovered():
		start_label.scale.x = lerpf(start_label.scale.x, 1.2, delta*3)
		start_label.scale.y = lerpf(start_label.scale.y, 1.2, delta*3)
		start_label.text = "-play again-"
	else:
		start_label.scale.x = lerpf(start_label.scale.x, 1.0, delta*3)
		start_label.scale.y = lerpf(start_label.scale.y, 1.0, delta*3)
		start_label.text = "play again"
	
	if quit_label.is_hovered():
		quit_label.scale.x = lerpf(quit_label.scale.x, 1.2, delta*3)
		quit_label.scale.y = lerpf(quit_label.scale.y, 1.2, delta*3)
		quit_label.text = "-main menu-"
	else:
		quit_label.scale.x = lerpf(quit_label.scale.x, 1.0, delta*3)
		quit_label.scale.y = lerpf(quit_label.scale.y, 1.0, delta*3)
		quit_label.text = "main menu"

func _on_start_label_pressed() -> void:
	Music.lost = false
	get_tree().change_scene_to_file("res://scenes/loading.tscn")


func _on_quit_label_pressed() -> void:
	Music.lost = false
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")
