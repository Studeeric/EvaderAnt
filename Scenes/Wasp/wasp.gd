extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $WaspArea/Sprite2D

var target: CharacterBody2D
var target_position: Vector2
@export var speed: float = 25
@onready var despawner: Timer = $Despawner

var current_speed: float

func _ready() -> void:
	target = get_tree().get_first_node_in_group("player") as CharacterBody2D

func _physics_process(_delta: float) -> void:
	target_position = (target.position - position).normalized()
	velocity = target_position * current_speed
	sprite_2d.flip_h = target_position.x > 0
	move_and_slide()
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	despawner.start()
	current_speed = speed * 2


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	despawner.stop()
	current_speed = speed


func _on_despawner_timeout() -> void:
	queue_free()
