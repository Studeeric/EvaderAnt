extends CharacterBody2D

@onready var animator: AnimatedSprite2D = $Animator

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventManager.player_died.connect(handleDeath)

func handleDeath() -> void:
	animator.play("die")
