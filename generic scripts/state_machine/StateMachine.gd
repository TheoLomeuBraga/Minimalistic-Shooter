extends Node
class_name StateMachine


#var state : StateMachine

#func change(change_to: String)->void:
#	var new_state : StateMachine = get_node(change_to)
#	if new_state != null:
#		if state != null:
#			state.exit()
#		state = new_state
#		state.enter()
#		state.change.connect(change)

signal change(change_to: String)

func enter() -> void:
	pass

func process(delta: float) -> void:
	pass

func physics_process(delta: float) -> void:
	pass

func exit() -> void:
	pass
	
