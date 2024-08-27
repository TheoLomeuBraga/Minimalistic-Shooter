extends Node

var state : StateMachine

func change(change_to: String)->void:
	var new_state : StateMachine = get_node(change_to)
	if new_state != null:
		if state != null:
			state.exit()
		state = new_state
		state.enter()
		state.change.connect(change)

func _ready() -> void:
	change("wait")

func _process(delta: float) -> void:
	state.process(delta)
