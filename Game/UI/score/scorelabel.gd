extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventManager.set_score.connect(set_score_text)

func set_score_text(newTime: int) -> void:
	#text = str(newTime).pad_decimals(2)
	text = "%012d" % newTime
