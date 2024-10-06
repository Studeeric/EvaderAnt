extends State

@export var idleState: State
@export var jumpState: State
@export var fallState: State

func enter(machine: StateMachine) -> void:
	super(machine)
	pass

func exit() -> void:
	pass

func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	if !stateMachine.actor.is_on_floor():
		stateMachine.change_state(fallState)
		return
	
	if Input.is_action_just_pressed("jump"):
		stateMachine.change_state(jumpState)
		return
	
	var direction: float = Input.get_axis("move_left", "move_right")
	if direction == 0:
		stateMachine.change_state(idleState)
		return
	
	stateMachine.animator.flip_h = direction < 0
	
	stateMachine.actor.velocity.x = direction * stateMachine.moveSpeed
	stateMachine.actor.move_and_slide()
