extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventManager.player_died.connect(handlePlayerDied)

func handlePlayerDied() -> void:
	get_tree().paused = true
