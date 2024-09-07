extends Area3D



func _ready() -> void:
	pass # Replace with function body.

@export var health : float = 25

func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body == Global.player:
		Global.player.health += health
		if Global.player.health > Global.player.max_health:
			Global.player.health = Global.player.max_health
			
			Global.player.damage_vision_polution = 1.0
			Global.player.damage_color = Color.GREEN
