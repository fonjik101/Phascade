extends Control # класс нода к которому приклеплен скрипт

# делаем "референсы" на ноды что бы мы могли ими управлять позже
# @onready позволяет нам взять ноды перед тем как код начнет работать, иначе могут быть ошибки
@onready var point1: Sprite2D = $Point1 # улика 1
@onready var point2: Sprite2D = $Point2 # улика 2
@onready var point3: Sprite2D = $Point3 # улика 3

@onready var emf_texture: AnimatedSprite2D = $EMF_Item/EMF_Texture # текстура ЕМF которая будет следовать за курсором игрока
@onready var emf_item: CharacterBody2D = $EMF_Item
@onready var thermometer_item: Sprite2D = $Thermometer_Item # текстура Термометра которая будет следовать за курсором игрока
@onready var uv_item: Sprite2D = $UV_Item # текстура UV которая будет следовать за курсором игрока

@onready var item_button_1: Button = $Item_Button1 #кнопки интерфейса
@onready var item_button_2: Button = $Item_Button2
@onready var item_button_3: Button = $Item_Button3
@onready var item_button_4: Button = $Item_Button4
@onready var item_button_5: Button = $Item_Button5


# переменные
#var - указание что это новая переменная
#item_selected - название переменной
#: Int - тип данных который будет хранится в переменной
# = 1 - значение переменной
var item_selected: int = 0 # перемення которая определяет какой предмет держит игрок
var activity_level: int = 0 # уровень активности (как близко игрок к улике)
var is_emf_active: bool = false
var ghost_agression: float = 0.0

#выполняется только раз, при запуске сцены
func _ready() -> void:
	point1.global_position = Vector2(randi_range(20,520),randi_range(20,420))
	point2.global_position = Vector2(randi_range(20,520),randi_range(20,420))
	point3.global_position = Vector2(randi_range(20,520),randi_range(20,420))
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

#выполнятся каждый кадр, НЕ КАЖДУЮ СЕКУНДУ, А КАЖДЫЙ КАДР!!!!!
func _process(delta):
	point1.global_position = Vector2(randi_range(20,520),randi_range(20,420))
	point2.global_position = Vector2(randi_range(20,520),randi_range(20,420))
	point3.global_position = Vector2(randi_range(20,520),randi_range(20,420))
	
	#двигаем предмет к мышки игрока
	emf_item.global_position.x = lerpf(emf_item.global_position.x, get_global_mouse_position().x, delta * 10)
	emf_item.global_position.y = lerpf(emf_item.global_position.y, get_global_mouse_position().y, delta * 10)
	#emf_item.global_position = get_global_mouse_position() <- по сути код сверху и это делают одно и тоже, но код сверху делает это красиво
	
	emf_item.visible = (item_selected == 1)
	thermometer_item.visible = (item_selected == 2)
	uv_item.visible = (item_selected == 3)
	
	if emf_item.visible:
		_check_point1()

# вынес блок кода в отдельную функцию, для организации
func _check_point1():
	print(activity_level)
	emf_texture.frame=activity_level

func _on_item_button_1_pressed() -> void:
	item_selected = 1
func _on_item_button_2_pressed() -> void:
	item_selected = 2
func _on_item_button_3_pressed() -> void:
	item_selected = 3
func _on_item_button_4_pressed() -> void:
	item_selected = 4
func _on_item_button_5_pressed() -> void:
	item_selected = 5
