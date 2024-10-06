extends Area2D
class_name Hurtbox

@onready var hurt_cooldown: Timer = $HurtCooldown
@onready var hurt_audio: AudioStreamPlayer2D = $HurtAudio

@export var hurt_sound: AudioStream

func _ready() -> void:
	if hurt_sound:
		hurt_audio.stream = hurt_sound

func _on_body_entered(_body: Node2D) -> void:
	if hurt_cooldown.is_stopped():
		hurt_audio.play()
		EventManager.take_damage.emit()
		hurt_cooldown.start()


func _on_hurt_cooldown_timeout() -> void:
	EventManager.immunity_over.emit()
