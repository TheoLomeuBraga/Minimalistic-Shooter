extends GenericPathFinder

var health : int = 10

func movement_plugin(delta: float) -> void:
	go = global_position.distance_to(Global.player.global_position) > 5
