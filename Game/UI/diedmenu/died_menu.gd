extends PanelContainer

@onready var score_value_label: Label = $VBoxContainer/VBoxContainer/ScoreValueLabel
@onready var player_name: LineEdit = $VBoxContainer/PlayerName
@onready var submit_button: Button = $"VBoxContainer/Submit Button"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var scoreVal: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventManager.set_score.connect(setScoreLabel)
	EventManager.player_died.connect(setVisible)

func _process(_delta: float) -> void:
	submit_button.disabled = player_name.text.length() < 3

func setScoreLabel(newScore: int) -> void:
	scoreVal = newScore
	score_value_label.text = "%012d" % newScore

func _on_main_menu_button_pressed() -> void:
	animation_player.play("main_pressed")

func _on_submit_button_pressed() -> void:
	animation_player.play("submit_pressed")
	var score: Score = Score.new()
	score.player_name = player_name.text
	score.player_score = scoreVal
	EventManager.score_submitted.emit(score)
	player_name.text = ""
	player_name.editable = false

func setVisible() -> void:
	visible = true


func _on_retry_button_pressed() -> void:
	animation_player.play("retry_pressed")
	disable_menu()

func disable_menu() -> void:
	for child: Node in v_box_container.get_children():
		if child is Button:
			child.disabled = true

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == &"retry_pressed":
		get_tree().paused = false
		get_tree().change_scene_to_file("res://Game/world.tscn")
	if anim_name == &"main_pressed":
		get_tree().paused = false
		get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")


func _on_visibility_changed() -> void:
	if visible:
		audio_stream_player_2d.play()
