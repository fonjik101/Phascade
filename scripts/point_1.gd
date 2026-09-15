extends Sprite2D

@onready var main_node: Control = $".."

func _on_level_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("item"):
		main_node.activity_level += 1

func _on_level_1_body_exited(body: Node2D) -> void:
	if body.is_in_group("item"):
		main_node.activity_level -= 1

func _on_level_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("item"):
		main_node.activity_level += 1

func _on_level_2_body_exited(body: Node2D) -> void:
	if body.is_in_group("item"):
		main_node.activity_level -= 1

func _on_level_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("item"):
		main_node.activity_level += 1

func _on_level_3_body_exited(body: Node2D) -> void:
	if body.is_in_group("item"):
		main_node.activity_level -= 1

func _on_level_4_body_entered(body: Node2D) -> void:
	if body.is_in_group("item"):
		main_node.activity_level += 1

func _on_level_4_body_exited(body: Node2D) -> void:
	if body.is_in_group("item"):
		main_node.activity_level -= 1

func _on_level_5_body_entered(body: Node2D) -> void:
	if body.is_in_group("item"):
		main_node.activity_level += 1

func _on_level_5_body_exited(body: Node2D) -> void: 
	if body.is_in_group("item"):
		main_node.activity_level -= 1
