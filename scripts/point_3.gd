extends Sprite2D

@onready var main_node: Control = $".."

func _physics_process(delta: float) -> void:
	if main_node.temperature_display_fin == -5.0 and (20.0-(main_node.temperature_level1*5)) == -5.0:
		main_node.thermo_discovered_times += 1
		queue_free()

func _on_level_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("item"):
		main_node.temperature_level1 += 1

func _on_level_1_body_exited(body: Node2D) -> void:
	if body.is_in_group("item"):
		main_node.temperature_level1 -= 1

func _on_level_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("item"):
		main_node.temperature_level1 += 1

func _on_level_2_body_exited(body: Node2D) -> void:
	if body.is_in_group("item"):
		main_node.temperature_level1 -= 1

func _on_level_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("item"):
		main_node.temperature_level1 += 1

func _on_level_3_body_exited(body: Node2D) -> void:
	if body.is_in_group("item"):
		main_node.temperature_level1 -= 1

func _on_level_4_body_entered(body: Node2D) -> void:
	if body.is_in_group("item"):
		main_node.temperature_level1 += 1

func _on_level_4_body_exited(body: Node2D) -> void:
	if body.is_in_group("item"):
		main_node.temperature_level1 -= 1

func _on_level_5_body_entered(body: Node2D) -> void:
	if body.is_in_group("item"):
		main_node.temperature_level1 += 1

func _on_level_5_body_exited(body: Node2D) -> void: 
	if body.is_in_group("item"):
		main_node.temperature_level1 -= 1
