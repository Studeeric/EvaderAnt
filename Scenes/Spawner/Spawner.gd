extends Node
class_name Spawner

const FRUIT: PackedScene = preload("res://Scenes/Fruit/fruit.tscn")
@onready var wasp_spawner: PathFollow2D = $WaspTrack/WaspSpawner
@onready var wasp_position: Marker2D = $WaspTrack/WaspSpawner/WaspPosition

const WASP: PackedScene = preload("res://Scenes/Wasp/wasp.tscn")
@onready var strawberry_spawner: PathFollow2D = $StrawberryTrack/StrawberrySpawner
@onready var strawberry_position: Marker2D = $StrawberryTrack/StrawberrySpawner/StrawberryPosition

const ROLY_POLY = preload("res://Scenes/RolyPoly/roly_poly.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()


func _on_wasp_timer_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	wasp_spawner.progress_ratio = rng.randf()
	var instance: CharacterBody2D = WASP.instantiate() as CharacterBody2D
	
	instance.global_position = wasp_position.global_position
	get_tree().current_scene.add_child(instance)


func _on_strawberry_timer_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	strawberry_spawner.progress = rng.randf_range(0, 706)
	
	while strawberry_spawner.progress > 108 and strawberry_spawner.progress < 511:
		strawberry_spawner.progress = rng.randf_range(0, 706)
	
	var instance: Area2D = FRUIT.instantiate() as Area2D
	
	instance.global_position = strawberry_position.global_position
	get_tree().current_scene.add_child(instance)

func _on_roly_poly_timer_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	strawberry_spawner.progress_ratio = rng.randf()
	
	while strawberry_spawner.progress > 108 and strawberry_spawner.progress < 511:
		strawberry_spawner.progress_ratio = rng.randf()
	
	var instance: CharacterBody2D = ROLY_POLY.instantiate() as CharacterBody2D
	
	instance.global_position = strawberry_position.global_position
	get_tree().current_scene.add_child(instance)
