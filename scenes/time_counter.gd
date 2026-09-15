extends Label

var total_seconds: int = 0

func _ready() -> void:
	_update_label()

func _on_timer_timeout() -> void:
	total_seconds += 1
	_update_label()

func _update_label() -> void:
	var minutes: int = total_seconds / 60
	var seconds: int = total_seconds % 60
	text = "%02d:%02d" % [minutes, seconds]
