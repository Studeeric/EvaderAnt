extends PanelContainer
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

@export var highscores: Highscores
const SCORE: PackedScene = preload("res://Game/UI/Leaderboard/Score/score.tscn")
@onready var v_box_container: VBoxContainer = $VBoxContainer
const MAIN_MENU = preload("res://MainMenu/main_menu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	highscores.highscores.sort_custom(sort_descending)
	var index: int = 1
	for score: Score in highscores.highscores:
		var hbox: HBoxContainer = HBoxContainer.new()
		var rankLabel: Label = Label.new()
		var scoreContainer: ScoreContainer = SCORE.instantiate()
		
		rankLabel.text = str(index, ".")
		rankLabel.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		scoreContainer.scoreResource = score
		hbox.add_child(rankLabel)
		hbox.add_child(scoreContainer)
		
		v_box_container.add_child(hbox)
		index += 1

func sort_descending(a: Score, b: Score) -> bool:
	if a.player_score > b.player_score:
		return true
	return false


func _on_button_pressed() -> void:
	animation_player.play("main_pressed")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")
