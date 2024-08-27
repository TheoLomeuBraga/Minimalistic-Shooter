extends StateMachine



func enter() -> void:
	print("start to wait")

var timer := 2.0
func process(delta: float) -> void:
	print(timer)
	if timer <= 0:
		change.emit("end")
	else:
		timer -= delta
	
func exit() -> void:
	print("im tired")
