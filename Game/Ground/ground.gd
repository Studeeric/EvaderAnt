extends StaticBody2D
class_name Ground

const GROUND: PackedScene = preload("res://Game/Ground/ground.tscn")

var leftGround: Ground
var rightGround: Ground

@onready var right_marker: Marker2D = $RightMarker
@onready var left_marker: Marker2D = $LeftMarker

var leftDeleteActive: bool
var rightDeleteActive: bool

func _on_right_area_entered(area: Area2D) -> void:
	if area.name == "RightCamArea" and rightGround == null:
		var newGround: Ground = GROUND.instantiate() as Ground
		newGround.position = to_global(right_marker.position)
		call_deferred("add_sibling", newGround)
		newGround.leftGround = self
		rightGround = newGround


func _on_left_area_entered(area: Area2D) -> void:
	if area.name == "LeftCamArea" and leftGround == null:
		var newGround: Ground = GROUND.instantiate()
		newGround.position = to_global(left_marker.position)
		call_deferred("add_sibling", newGround)
		newGround.rightGround = self
		leftGround = newGround
