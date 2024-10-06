extends CharacterBody2D
@onready var sprite: Sprite2D = $Sprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var despawn_timer: Timer = $DespawnTimer


@export var move_speed: float = 10
var direction: float
var is_moving: bool = true

func _ready() -> void:
	direction = move_speed * get_direction_modifier()

func _physics_process(_delta: float) -> void:
	if !is_on_floor():
		velocity.y += 1000
	else:
		velocity.y = 0
	
	if is_moving:
		velocity.x = direction
		sprite.flip_h = velocity.x < 0
	else:
		velocity.x = 0
	
	move_and_slide()

func get_direction_modifier() -> int:
	var num: float = randf_range(-1, 1)
	
	if num < 0:
		return -1
	else:
		return 1


func _on_area_2d_body_entered(_body: Node2D) -> void:
	is_moving = false
	animation_player.play("curl")


func _on_area_2d_body_exited(_body: Node2D) -> void:
	animation_player.play("walk")
	is_moving = true


func _on_despawn_timer_timeout() -> void:
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	despawn_timer.stop()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	despawn_timer.start()
