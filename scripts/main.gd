extends Control # класс нода к которому приклеплен скрипт

# делаем "референсы" на ноды что бы мы могли ими управлять позже
# @onready позволяет нам взять ноды перед тем как код начнет работать, иначе могут быть ошибки
@onready var point1: Sprite2D = $Point1 # улика 1
@onready var point2: Sprite2D = $Point2 # улика 2
@onready var point3: Sprite2D = $Point3 # улика 3
@onready var point_ghost: CharacterBody2D = $PointGhost

@onready var handprint: Sprite2D = $Point2/Handprint

@onready var item_texture: AnimatedSprite2D = $Item_Cursor/Item_Texture # текстура ЕМF которая будет следовать за курсором игрока
@onready var item_cursor: CharacterBody2D = $Item_Cursor
@onready var camcoder_cursor: Sprite2D = $Camcoder_Cursor
@onready var temp_label: Label = $Item_Cursor/Temp_Label
@onready var insence_cursor: CharacterBody2D = $Insence_Cursor

@onready var item_button_1: Button = $Item_Button1 #кнопки интерфейса
@onready var item_button_2: Button = $Item_Button2
@onready var item_button_3: Button = $Item_Button3
@onready var item_button_4: Button = $Item_Button4
@onready var item_button_5: Button = $Item_Button5

@onready var emf_check: CheckBox = $EmfCheck
@onready var uv_check: CheckBox = $UvCheck
@onready var temp_check: CheckBox = $TempCheck

@onready var press: AudioStreamPlayer = $Press
@onready var woosh: AudioStreamPlayer = $Woosh
@onready var hover: AudioStreamPlayer = $Hover
@onready var click: AudioStreamPlayer = $Click

# переменные
#var - указание что это новая переменная
#item_selected - название переменной
#: Int - тип данных который будет хранится в переменной
# = 1 - значение переменной
var item_selected: int = 0 # перемення которая определяет какой предмет держит игрок
var mouse_position: Vector2
var chance: int = 100

var activity_level: int = 0 # уровень активности емф (как близко игрок к улике)
var temperature_level1: float = 0.0 # уровень активности градусника (как близко игрок к улике)
var temperature_level2: float = 0.0 # уровень активности градусника (как близко игрок к улике)
var uv_level: float = -3.0 # уровень активности юв (как долго отпечаток был освещен)

var activity_display: float
var uv_display: float
var temperature_display: float = 20.0
var temperature_display_fin: float = 20.0

var is_emf_active: bool = false
var is_thermo_active: bool = false
var is_uv_active: bool = false

var emf_discovered: bool = false
var thermo_discovered: bool = false
var uv_discovered: bool = false
var thermo_discovered_times: int = 0

var ghost_agression: float = 0.0
var ghost_active: bool = false
var ghost_ready: bool = false

#выполняется только раз, при запуске сцены
func _ready() -> void:
	Music.is_hunting = false
	Music.is_danger = true
	$ScoreLabel.text = str(GlobalVars.score)
	point1.global_position = Vector2(randi_range(40,500),randi_range(40,440))
	point2.global_position = Vector2(randi_range(40,500),randi_range(40,440))
	point3.global_position = Vector2(randi_range(40,500),randi_range(40,440))
	$Point4.global_position = Vector2(randi_range(40,500),randi_range(40,440))
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

#выполнятся каждый кадр, MainНЕ КАЖДУЮ СЕКУНДУ, А КАЖДЫЙ КАДР!!!!!
func _process(delta):
	if !ghost_active:
		ghost_agression += 0.01
		ghost_agression += float(int(GlobalVars.score/100))/100
	if uv_discovered and !ghost_active:
		ghost_agression += 0.02
	if emf_discovered and !ghost_active:
		ghost_agression += 0.02
	if thermo_discovered and !ghost_active:
		ghost_agression += 0.02
	
	$HuntingTimeLabel.visible = ghost_active
	if ghost_active or $TimeLabel.total_seconds < 10: ghost_agression = 0
	
	if (chance < ghost_agression) or $TimeLabel.total_seconds < 10:
		ghost_active = true
		if $TimeLabel.total_seconds < 10:
			$TimeLabel.modulate = Color(1.0, 0.0, 0.0, 1.0)
		print("ghost angy")
		if !ghost_ready:
			ghost_ready = true
			point_ghost.global_position = Vector2(randi_range(40,500),randi_range(40,440))
			point_ghost.show()
			point_ghost._start_hunt()
			print("did ghost")
			
	
	if ghost_active:
		$Black_Rect2.visible = (randi_range(1,3) == 1)
	else:
		$Black_Rect2.visible = false
	
	$NextLabel.visible = emf_discovered and uv_discovered and thermo_discovered
	
	emf_check.button_pressed = emf_discovered
	emf_check.disabled = emf_discovered
	clampi(activity_level,0,5)
	
	uv_check.button_pressed = uv_discovered
	uv_check.disabled = uv_discovered
	uv_display = clamp(uv_display,0.0,1.0)
	handprint.modulate.a = uv_display
	
	temp_check.button_pressed = thermo_discovered
	temp_check.disabled = thermo_discovered
	temp_check.text = str("Freezing Temp (", thermo_discovered_times, "/2)")
	if is_thermo_active and thermo_discovered_times == 0:
		temperature_display = lerpf(temperature_display,(20.0-(temperature_level1*5)),delta*2)
	elif is_thermo_active and thermo_discovered_times == 1:
		temperature_display = lerpf(temperature_display,(20.0-(temperature_level2*5)),delta*2)
	else:
		temperature_display = 20.0
	temperature_display_fin = snappedf(temperature_display, 0.1)
	
	#двигаем предмет к мышки игрока
	item_cursor.global_position.x = lerpf(item_cursor.global_position.x, mouse_position.x, delta * 10)
	item_cursor.global_position.y = lerpf(item_cursor.global_position.y, mouse_position.y, delta * 10)
	camcoder_cursor.global_position.x = lerpf(camcoder_cursor.global_position.x, mouse_position.x, delta * 10)
	camcoder_cursor.global_position.y = lerpf(camcoder_cursor.global_position.y, mouse_position.y, delta * 10)
	insence_cursor.global_position.x = lerpf(insence_cursor.global_position.x, mouse_position.x, delta * 10)
	insence_cursor.global_position.y = lerpf(insence_cursor.global_position.y, mouse_position.y, delta * 10)
	#emf_item.global_position = get_global_mouse_position() <- по сути код сверху и это делают одно и тоже, но код сверху делает это красиво
	
	if item_selected == 1:
		_check_point1()
		item_texture.animation = "emf"
	elif item_selected == 2:
		_check_point2()
		item_texture.animation = "uv"
	elif item_selected == 3:
		_check_point3()
		item_texture.animation = "thermo"
	elif item_selected == 5 and Input.is_action_pressed("Primary"):
		_checl_ghost()
		
	item_cursor.visible = (item_selected == 1 or item_selected == 2 or item_selected == 3)
	camcoder_cursor.visible = (item_selected == 4)
	insence_cursor.visible = (item_selected == 5)
	temp_label.visible = (item_selected == 3) and Input.is_action_pressed("Primary")
	is_thermo_active = (item_selected == 3) and Input.is_action_pressed("Primary")
	is_uv_active = (item_selected == 2)
	is_emf_active = (item_selected == 1) and Input.is_action_pressed("Primary")
	
	if Input.is_action_pressed("Primary"):
		activity_display = lerpf(activity_display,activity_level+1,delta*2)
	else:
		activity_display = lerpf(activity_display,0,delta*5)
		mouse_position.x = clampf(get_global_mouse_position().x, 40, 500)
		mouse_position.y = clampf(get_global_mouse_position().y, 40, 440)
	
	if is_uv_active:
		uv_display += uv_level/1000
	else:
		uv_display -= 0.003

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Primary"):
		if (item_selected == 1) or (item_selected == 2) or (item_selected == 3) or (item_selected == 5):
			click.play()
	if Input.is_action_just_released("Primary"):
		if (item_selected == 1) or (item_selected == 3):
			click.play()

# вынес блок кода в отдельную функцию, для организации
func _check_point1():
	if ghost_active:
		item_texture.frame = randi_range(1,5)
	else:
		item_texture.frame = activity_display
	if activity_display >= 5:
		emf_discovered = true

func _check_point2():
	point2.visible = true
	item_texture.play("uv")
	if handprint.modulate.a >= 1.0:
		uv_discovered = true

func _check_point3():
	temp_label.text = str(temperature_display_fin)
	if thermo_discovered_times == 2:
		thermo_discovered = true

func _checl_ghost():
	if !ghost_active: return
	point_ghost.check_insence()
	if point_ghost.insence_in:
		ghost_active = false
		ghost_ready = false
		point_ghost.hide()

func _on_item_button_1_pressed() -> void:
	press.play()
	item_selected = 1
func _on_item_button_2_pressed() -> void:
	press.play()
	item_selected = 2
func _on_item_button_3_pressed() -> void:
	press.play()
	item_selected = 3
func _on_item_button_4_pressed() -> void:
	press.play()
	item_selected = 4
func _on_item_button_5_pressed() -> void:
	press.play()
	item_selected = 5


func _on_next_label_pressed() -> void:
	press.play()
	woosh.play()
	$NextLabel.disabled = true
	$AnimationPlayer.play("out_load")
	$Black_Rect2.mouse_filter = 0
	await $AnimationPlayer.animation_finished
	GlobalVars.score += $TimeLabel.total_seconds
	if GlobalVars.score > GlobalVars.high_score:
		GlobalVars.high_score = GlobalVars.score
		GlobalVars.write_save()
		print("New High Score!")
	print("Added: ", $TimeLabel.total_seconds, " To: ", GlobalVars.score)
	get_tree().change_scene_to_file("res://scenes/loading.tscn")
	Music.is_danger = false


func _on_timer_timeout() -> void:
	chance = randi_range(30,200)
	if $TimeLabel.total_seconds == 0:
		get_tree().change_scene_to_file("res://scenes/Loose.tscn")
