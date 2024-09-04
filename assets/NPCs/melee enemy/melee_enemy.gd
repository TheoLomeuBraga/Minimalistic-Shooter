extends GenericPathFinder


func _init() -> void:
	pass


func movement_plugin(delta: float) -> void:
	target_location = Global.player.global_position
	go = global_position.distance_to(target_location) > 2
