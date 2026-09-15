extends TextureRect

@onready var texture_rect: TextureRect = $"."

var background_1: Texture2D = preload("res://textures/backgrounds/background1.jpg")
var background_2: Texture2D = preload("res://textures/backgrounds/background2.jpg")
var background_3: Texture2D = preload("res://textures/backgrounds/background3.jpg")
var background_4: Texture2D = preload("res://textures/backgrounds/background4.jpg")

func _ready() -> void:
	var number = randi_range(1,4)
	if number == 1:
		texture_rect.texture = background_1
	elif number == 2:
		texture_rect.texture = background_2
	elif number == 3:
		texture_rect.texture = background_3
	elif number == 4:
		texture_rect.texture = background_4
