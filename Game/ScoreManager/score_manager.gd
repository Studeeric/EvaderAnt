extends Node
class_name ScoreManager

@export var high_scores: Highscores

var time_elapsed: float = 0.0
var score: int

@export var second_score: int = 100

func _ready() -> void:
	EventManager.set_timer.emit(time_elapsed)
	EventManager.score_submitted.connect(submit_score)
	EventManager.points_earned.connect(add_score)

func _process(delta: float) -> void:
	time_elapsed += delta
	EventManager.set_timer.emit(time_elapsed)

func _on_timer_timeout() -> void:
	add_score(second_score)

func add_score(additive: int) -> void:
	score += additive
	EventManager.set_score.emit(score)

func submit_score(newScore: Score) -> void:
	high_scores.highscores.append(newScore)
	high_scores.highscores.sort_custom(sort_descending)
	high_scores.highscores.remove_at(high_scores.highscores.size() - 1)
	ResourceSaver.save(high_scores)

func sort_descending(a: Score, b: Score) -> bool:
	if a.player_score > b.player_score:
		return true
	return false
