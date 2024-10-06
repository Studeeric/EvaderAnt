extends Area2D
class_name Fruit

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var points: int = 500


func _on_body_entered(_body: Node2D) -> void:
	EventManager.points_earned.emit(points)
	audio_stream_player_2d.play()
	sprite_2d.visible = false


func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
