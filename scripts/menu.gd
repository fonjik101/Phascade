extends Control

@onready var item_cursor: CharacterBody2D = $Item_Cursor
@onready var item_texture: AnimatedSprite2D = $Item_Cursor/Item_Texture

func _ready() -> void:
	item_texture.animation = "emf"

func _process(delta: float) -> void:
	item_cursor.global_position.x = clampf(get_global_mouse_position().x, 40, 500)
	item_cursor.global_position.y = clampf(get_global_mouse_position().y, 40, 500)
