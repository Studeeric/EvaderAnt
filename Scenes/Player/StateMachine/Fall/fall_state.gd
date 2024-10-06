extends State

@export var idleState: State
@export var moveState: State

func enter(machine: StateMachine) -> void:
	super(machine)
	pass

func exit() -> void:
	pass

func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	var direction: float = Input.get_axis("move_left", "move_right")
	
	if stateMachine.actor.is_on_floor():
		if direction != 0:
			stateMachine.change_state(moveState)
		else:
			stateMachine.change_state(idleState)
	
	if direction < 0:
		stateMachine.animator.flip_h = true
	elif direction > 0:
		stateMachine.animator.flip_h = false
	
	stateMachine.actor.velocity.y += stateMachine.gravity
	stateMachine.actor.velocity.x = direction * stateMachine.moveSpeed
	stateMachine.actor.move_and_slide()
