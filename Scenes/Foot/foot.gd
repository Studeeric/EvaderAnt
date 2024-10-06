extends CharacterBody2D


var target: CharacterBody2D
var target_position: Vector2
var foot_height: float = -32

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var fall_timer: Timer = $FallTimer
@onready var track_timer: Timer = $TrackTimer
@onready var ground_timer: Timer = $GroundTimer

@export var speed: float = 1500

var is_sound_played: bool = false


func _ready() -> void:
	target = get_tree().get_first_node_in_group("player") as CharacterBody2D

func _physics_process(_delta: float) -> void:
	
	if !track_timer.is_stopped() and fall_timer.is_stopped():
		target_position = (target.position - position).normalized()
		velocity.x = target_position.x * speed
	
	if is_on_floor() and ground_timer.is_stopped():
		ground_timer.start()
		if !is_sound_played:
			audio_stream_player_2d.play()
			is_sound_played = true
	
	if position.y < foot_height:
		velocity.y = 0
		position.y = foot_height
		track_timer.start()
	
	move_and_slide()
	
func _on_track_timer_timeout() -> void:
	animation_player.play("rumble")
	velocity.x = 0
	fall_timer.start()
	is_sound_played = false


func _on_fall_timer_timeout() -> void:
	animation_player.play("RESET")
	velocity.y = 500


func _on_ground_timer_timeout() -> void:
	if is_on_floor():
		velocity.y = -200
