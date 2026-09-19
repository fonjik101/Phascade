extends Control

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")
