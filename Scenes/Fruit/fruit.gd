extends Area2D
class_name Fruit

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var points: int = 500
const FRUIT_EAT: PackedScene = preload("res://Scenes/Fruit/FruitEat.tscn")

func _on_body_entered(_body: Node2D) -> void:
	EventManager.points_earned.emit(points)
	audio_stream_player_2d.play()
	sprite_2d.visible = false
	play_effect()


func _on_audio_stream_player_2d_finished() -> void:
	queue_free()

func play_effect() -> void:
	var eff: CPUParticles2D = FRUIT_EAT.instantiate() as CPUParticles2D
	eff.global_position = global_position
	eff.emitting = true
	add_sibling(eff)
