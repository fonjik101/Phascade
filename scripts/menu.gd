extends Control

@export var speed: float = 1.0

@onready var high_score_label: Label = $HighScoreLabel
@onready var credits_panel: Panel = $CreditsPanel

@onready var start_label: Button = $StartLabel
@onready var credits_label: Button = $CreditsLabel
@onready var tutorial_label: Button = $TutorialLabel
@onready var quit_label: Button = $QuitLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	GlobalVars.read_save()
	high_score_label.text = str("High score: ",GlobalVars.high_score)
	GlobalVars.score = 0

func _process(delta: float) -> void:
	var t := Time.get_ticks_msec() / 1000.0 * speed
	quit_label.modulate = Color(
		sin(t) * 0.5 + 0.5,
		sin(t + TAU / 3.0) * 0.5 + 0.5,
		sin(t + TAU * 2.0 / 3.0) * 0.5 + 0.5
	)
	
	$Line.modulate.a = sin(t / 2.0)
	
	if start_label.is_hovered():
		start_label.scale.x = lerpf(start_label.scale.x, 1.2, delta*3)
		start_label.scale.y = lerpf(start_label.scale.y, 1.2, delta*3)
		start_label.text = "-start-"
	else:
		start_label.scale.x = lerpf(start_label.scale.x, 1.0, delta*3)
		start_label.scale.y = lerpf(start_label.scale.y, 1.0, delta*3)
		start_label.text = "start"
	
	if tutorial_label.is_hovered():
		tutorial_label.scale.x = lerpf(tutorial_label.scale.x, 1.2, delta*3)
		tutorial_label.scale.y = lerpf(tutorial_label.scale.y, 1.2, delta*3)
		tutorial_label.text = "-tutorial-"
	else:
		tutorial_label.scale.x = lerpf(tutorial_label.scale.x, 1.0, delta*3)
		tutorial_label.scale.y = lerpf(tutorial_label.scale.y, 1.0, delta*3)
		tutorial_label.text = "tutorial"
	
	if quit_label.is_hovered():
		quit_label.scale.x = lerpf(quit_label.scale.x, 1.2, delta*3)
		quit_label.scale.y = lerpf(quit_label.scale.y, 1.2, delta*3)
		quit_label.text = "-quit-"
	else:
		quit_label.scale.x = lerpf(quit_label.scale.x, 1.0, delta*3)
		quit_label.scale.y = lerpf(quit_label.scale.y, 1.0, delta*3)
		quit_label.text = "quit"
	
	if credits_label.is_hovered():
		credits_label.scale.x = lerpf(credits_label.scale.x, 1.1, delta*3)
		credits_label.scale.y = lerpf(credits_label.scale.y, 1.1, delta*3)
	else:
		credits_label.scale.x = lerpf(credits_label.scale.x, 1.0, delta*3)
		credits_label.scale.y = lerpf(credits_label.scale.y, 1.0, delta*3)

func _on_start_label_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Main.tscn")


func _on_credits_label_pressed() -> void:
	credits_panel.visible = !credits_panel.visible


func _on_quit_label_pressed() -> void:
	get_tree().quit()


func _on_tutorial_label_pressed() -> void:
	pass # Replace with function body.


#func _on_timer_timeout() -> void:
	#$Line.visible = !$Line.visible
