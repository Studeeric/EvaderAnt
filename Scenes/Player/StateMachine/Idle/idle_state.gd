extends State

@export var moveState: State
@export var jumpState: State
@export var fallState: State

func enter(machine: StateMachine) -> void:
	super(machine)
	pass

func exit() -> void:
	pass

func process(_delta: float) -> void:
	if !stateMachine.actor.is_on_floor():
		stateMachine.change_state(fallState)
		return
	
	if Input.is_action_just_pressed("jump"):
		stateMachine.change_state(jumpState)
		return
	
	if Input.get_axis("move_left", "move_right") != 0:
		stateMachine.change_state(moveState)
		return

func physics_process(_delta: float) -> void:
	pass
