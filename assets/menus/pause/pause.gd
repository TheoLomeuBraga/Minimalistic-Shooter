extends Control






func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if Global.is_paused:
			Global.unpause()
		else:
			Global.pause()
		
		visible = Global.is_paused


func _on_tree_exiting() -> void:
	Global.unpause()
