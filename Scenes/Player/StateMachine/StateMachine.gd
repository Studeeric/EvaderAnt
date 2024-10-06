extends Node
class_name StateMachine

@export var animator: AnimatedSprite2D
@export var actor: CharacterBody2D
@export var initialState: State

@export var gravity: float
@export var moveSpeed: float

var currentState: State
var is_hurting: bool = false

func _ready() -> void:
	if initialState:
		currentState = initialState
		currentState.enter(self)
	else:
		print_debug("No initial state.")
	EventManager.take_damage.connect(handlePlayerHurt)
	EventManager.immunity_over.connect(handleImmunityOver)

func _process(delta: float) -> void:
	if currentState:
		currentState.process(delta)
	else:
		print_debug("No current state.")
	
	if is_hurting:
		animator.play("hurt")

func _physics_process(delta: float) -> void:
	if currentState:
		currentState.physics_process(delta)
	else:
		print_debug("No current state.")

func change_state(new_state: State) -> void:
	if currentState:
		currentState.exit()
	
	currentState = new_state
	currentState.enter(self)

func handlePlayerHurt() -> void:
	is_hurting = true

func handleImmunityOver() -> void:
	is_hurting = false
	animator.play(currentState.animationName)
