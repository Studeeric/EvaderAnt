extends Node
class_name State

@export var animationName: StringName

var stateMachine: StateMachine

func enter(machine: StateMachine) -> void:
	stateMachine = machine
	stateMachine.animator.play(animationName)

func exit() -> void:
	pass

func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass
