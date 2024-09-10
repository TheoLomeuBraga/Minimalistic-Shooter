extends Area3D


@export var health : int = 25
func _ready() -> void:
	if health > 25:
		$display/health/health_smal.visible = false
		$display/health/health_big.visible = true

var utilized : bool = false
var wave_break_last_frame : bool = DungeonMaster.wave_break

func _process(delta: float) -> void:
	$display/health.rotation_degrees.y += delta * 50
	$display/health.visible = not utilized
	
	if wave_break_last_frame != DungeonMaster.wave_break and DungeonMaster.wave_break:
		utilized = false
	
	wave_break_last_frame = DungeonMaster.wave_break


func _on_body_entered(body: Node3D) -> void:
	if not utilized and body == Global.player:
		Global.player.health += health
		if Global.player.health > Global.player.max_health:
			Global.player.health = Global.player.max_health
			
			Global.player.damage_vision_polution = 1.0
			Global.player.damage_color = Color.GREEN
			
			utilized = true
