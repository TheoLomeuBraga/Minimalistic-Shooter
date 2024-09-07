extends Area3D





@export var pistol_sceane : PackedScene
@export var smg_sceane : PackedScene
@export var shotgum_sceane : PackedScene

var selected_gun : PackedScene

enum guns {
	pistol = 0,
	smg = 1,
	shotgum = 2,
}
@export var gun : guns

func _ready() -> void:
	$display/MeshInstance3D.visible = false
	if gun == 0:
		$display/Pistol.visible = true
		selected_gun = pistol_sceane
	if gun == 1:
		$display/Smg.visible = true
		selected_gun = smg_sceane
	if gun == 2:
		$display/Shotgum.visible = true
		selected_gun = shotgum_sceane
	
	

func _process(delta: float) -> void:
	$display.rotation_degrees.y += delta * 50


func _on_body_entered(body: Node3D) -> void:
	if body == Global.player:
		if Global.player.guns.count(selected_gun) == 0:
			Global.player.guns.push_back(selected_gun)
			Global.player.select_gun(0)
		
		queue_free()
