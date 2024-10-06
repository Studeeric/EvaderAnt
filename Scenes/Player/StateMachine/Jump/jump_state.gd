extends State

@export var fallState: State

@export var jump_force: float

func enter(machine: StateMachine) -> void:
	super(machine)
	stateMachine.actor.velocity.y = -jump_force

func exit() -> void:
	pass

func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	if Input.is_action_just_released("jump"):
		stateMachine.actor.velocity.y *= 0.5
		if stateMachine.actor.velocity.y <= 0:
			stateMachine.change_state(fallState)

	var direction: float = Input.get_axis("move_left", "move_right")
	stateMachine.actor.velocity.y += stateMachine.gravity
	stateMachine.actor.velocity.x = direction * stateMachine.moveSpeed
	
	if direction < 0:
		stateMachine.animator.flip_h = true
	elif direction > 0:
		stateMachine.animator.flip_h = false
	
	stateMachine.actor.move_and_slide()
	
	if stateMachine.actor.velocity.y >= 0:
		stateMachine.change_state(fallState)
