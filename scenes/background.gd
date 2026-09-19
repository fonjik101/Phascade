extends TextureRect

@onready var texture_rect: TextureRect = $"."
@onready var texture_rect_2: TextureRect = $"../../TextureRect2"

var background_1: Texture2D = preload("res://textures/backgrounds/background1.jpg")
var background_2: Texture2D = preload("res://textures/backgrounds/background2.jpg")
var background_3: Texture2D = preload("res://textures/backgrounds/background3.jpg")
var background_4: Texture2D = preload("res://textures/backgrounds/background4.jpg")

var nv_background_1: Texture2D = preload("res://textures/nv_backgrounds/background1.jpg")
var nv_background_2: Texture2D = preload("res://textures/nv_backgrounds/background2.jpg")
var nv_background_3: Texture2D = preload("res://textures/nv_backgrounds/background3.jpg")
var nv_background_4: Texture2D = preload("res://textures/nv_backgrounds/background4.jpg")

func _ready() -> void:
	var number = randi_range(1,4)
	if number == 1:
		texture_rect.texture = background_1
		texture_rect_2.texture = nv_background_1
	elif number == 2:
		texture_rect.texture = background_2
		texture_rect_2.texture = nv_background_2
	elif number == 3:
		texture_rect.texture = background_3
		texture_rect_2.texture = nv_background_3
	elif number == 4:
		texture_rect.texture = background_4
		texture_rect_2.texture = nv_background_4
