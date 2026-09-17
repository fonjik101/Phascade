extends Node

const SAVE_PATH := "user://save.tres"

var high_score: int
var score: int = 0

func write_save():
	var cfg = ConfigFile.new()
	cfg.set_value("game", "high_score", high_score)
	cfg.save(SAVE_PATH)

func read_save():
	var cfg = ConfigFile.new()
	if cfg.load(SAVE_PATH) == OK:
		high_score = cfg.get_value("game", "high_score", 0)
