extends HBoxContainer
class_name ScoreContainer

var scoreResource: Score
@onready var name_label: Label = $NameLabel
@onready var score_label: Label = $ScoreLabel


func _ready() -> void:
	name_label.text = scoreResource.player_name
	score_label.text = "%012d" % scoreResource.player_score
