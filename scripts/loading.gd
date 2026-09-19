extends Control

@onready var press: AudioStreamPlayer = $Press
@onready var woosh: AudioStreamPlayer = $Woosh
@onready var hover: AudioStreamPlayer = $Hover

@onready var title_label: Label = $TitleLabel
@onready var start_label: Button = $StartLabel

@export var speed: float = 10.0
var dots = 1
var arriving = false

func _ready() -> void:
	Music.is_hunting = true
	timer_1()
	$TitleLabel4.text = str("Current score: ", GlobalVars.score)

func _physics_process(delta: float) -> void:
	var t := Time.get_ticks_msec() / 1000.0 * speed
	title_label.modulate = Color(
		sin(t) * 0.5 + 0.5,
		sin(t + TAU / 3.0) * 0.5 + 0.5,
		sin(t + TAU * 2.0 / 3.0) * 0.5 + 0.5
	)
	
	if start_label.is_hovered():
		start_label.scale.x = lerpf(start_label.scale.x, 1.2, delta*3)
		start_label.scale.y = lerpf(start_label.scale.y, 1.2, delta*3)
		start_label.text = "-arrive now-"
	else:
		start_label.scale.x = lerpf(start_label.scale.x, 1.0, delta*3)
		start_label.scale.y = lerpf(start_label.scale.y, 1.0, delta*3)
		start_label.text = "arrive now"

func timer_1():
	if arriving: return
	hover.play()
	$TitleLabel3.text = "Arriving in: 5"
	await get_tree().create_timer(1.0).timeout
	timer_2()

func timer_2():
	if arriving: return
	hover.play()
	$TitleLabel3.text = "Arriving in: 4"
	await get_tree().create_timer(1.0).timeout
	timer_3()

func timer_3():
	if arriving: return
	hover.play()
	$TitleLabel3.text = "Arriving in: 3"
	await get_tree().create_timer(1.0).timeout
	timer_4()

func timer_4():
	if arriving: return
	hover.play()
	$TitleLabel3.text = "Arriving in: 2"
	await get_tree().create_timer(1.0).timeout
	timer_5()

func timer_5():
	if arriving: return
	hover.play()
	$TitleLabel3.text = "Arriving in: 1"
	await get_tree().create_timer(1.0).timeout
	timer_6()

func timer_6():
	hover.play()
	woosh.play()
	$TitleLabel3.text = "Arriving in: now!"
	$Black_Rect.mouse_filter = 0
	$AnimationPlayer.play("out_load")
	await $AnimationPlayer.animation_finished
	Music.is_hunting = false
	get_tree().change_scene_to_file("res://scenes/Main.tscn")


func _on_timer_timeout() -> void:
	dots += 1
	if dots == 4:
		dots = 1
	
	if dots == 1:
		$TitleLabel2.text = "Driving to the next location."
	elif dots == 2:
		$TitleLabel2.text = "Driving to the next location.."
	elif dots == 3:
		$TitleLabel2.text = "Driving to the next location..."


func _on_start_label_pressed() -> void:
	press.play()
	arriving = true
	timer_6()
