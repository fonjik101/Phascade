extends Control

@export var speed: float = 1.0

@onready var high_score_label: Label = $HighScoreLabel
@onready var credits_panel: Panel = $CreditsPanel

@onready var start_label: Button = $StartLabel
@onready var credits_label: Button = $CreditsLabel
@onready var tutorial_label: Button = $TutorialLabel
@onready var quit_label: Button = $QuitLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var x_button: Button = $XButton

@onready var press: AudioStreamPlayer = $Press
@onready var woosh: AudioStreamPlayer = $Woosh
@onready var hover: AudioStreamPlayer = $Hover

var start_hovered: bool = false
var credits_hovered: bool = false
var tutorial_hovered: bool = false
var quit_hovered: bool = false
var x_hovered: bool = false

func _ready() -> void:
	GlobalVars.read_save()
	high_score_label.text = str("High score: ",GlobalVars.high_score)
	GlobalVars.score = 0
	await $AnimationPlayer.animation_finished
	$Black_Rect.mouse_filter = 2

func _process(delta: float) -> void:
	if $MuteButton.button_pressed:
		$MuteButton.icon = preload("uid://cwfv5748b6024")
		$MuteButton.modulate = Color(0.462, 0.462, 0.462, 1.0)
		AudioServer.set_bus_mute(1,true)
	else:
		$MuteButton.icon = preload("uid://bjn3d71mgscst")
		$MuteButton.modulate = Color(1.0, 1.0, 1.0, 1.0)
		AudioServer.set_bus_mute(1,false)
	
	press.pitch_scale = randf_range(0.9,1.1)
	woosh.pitch_scale = randf_range(0.7,0.8)
	hover.pitch_scale = randf_range(0.7,0.8)
	
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
		if !start_hovered:
			start_hovered = true
			hover.play()
	else:
		start_label.scale.x = lerpf(start_label.scale.x, 1.0, delta*3)
		start_label.scale.y = lerpf(start_label.scale.y, 1.0, delta*3)
		start_label.text = "start"
		start_hovered = false
	
	if tutorial_label.is_hovered():
		tutorial_label.scale.x = lerpf(tutorial_label.scale.x, 1.2, delta*3)
		tutorial_label.scale.y = lerpf(tutorial_label.scale.y, 1.2, delta*3)
		tutorial_label.text = "-tutorial-"
		if !tutorial_hovered:
			tutorial_hovered = true
			hover.play()
	else:
		tutorial_label.scale.x = lerpf(tutorial_label.scale.x, 1.0, delta*3)
		tutorial_label.scale.y = lerpf(tutorial_label.scale.y, 1.0, delta*3)
		tutorial_label.text = "tutorial"
		tutorial_hovered = false
	
	if quit_label.is_hovered():
		quit_label.scale.x = lerpf(quit_label.scale.x, 1.2, delta*3)
		quit_label.scale.y = lerpf(quit_label.scale.y, 1.2, delta*3)
		quit_label.text = "-quit-"
		if !quit_hovered:
			quit_hovered = true
			hover.play()
	else:
		quit_label.scale.x = lerpf(quit_label.scale.x, 1.0, delta*3)
		quit_label.scale.y = lerpf(quit_label.scale.y, 1.0, delta*3)
		quit_label.text = "quit"
		quit_hovered = false
	
	if credits_label.is_hovered():
		credits_label.scale.x = lerpf(credits_label.scale.x, 1.1, delta*3)
		credits_label.scale.y = lerpf(credits_label.scale.y, 1.1, delta*3)
		if !credits_hovered:
			credits_hovered = true
			hover.play()
	else:
		credits_label.scale.x = lerpf(credits_label.scale.x, 1.0, delta*3)
		credits_label.scale.y = lerpf(credits_label.scale.y, 1.0, delta*3)
		credits_hovered = false
		
	if x_button.is_hovered():
		x_button.scale.x = lerpf(credits_label.scale.x, 1.1, delta*3)
		x_button.scale.y = lerpf(credits_label.scale.y, 1.1, delta*3)
	else:
		x_button.scale.x = lerpf(credits_label.scale.x, 1.0, delta*3)
		x_button.scale.y = lerpf(credits_label.scale.y, 1.0, delta*3)
		x_hovered = false

func _on_start_label_pressed() -> void:
	press.play()
	woosh.play()
	$AnimationPlayer.play("out")
	$Black_Rect.mouse_filter = 0
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/loading.tscn")


func _on_credits_label_pressed() -> void:
	press.play()
	credits_panel.visible = !credits_panel.visible


func _on_quit_label_pressed() -> void:
	press.play()
	get_tree().quit()


func _on_tutorial_label_pressed() -> void:
	press.play()
	$TabContainer.show()
	$XButton.show()

func _on_x_button_pressed() -> void:
	press.play()
	$TabContainer.hide()
	$XButton.hide()

func _on_tab_container_tab_changed(tab: int) -> void:
	press.play()


func _on_tab_container_tab_hovered(tab: int) -> void:
	hover.play()
