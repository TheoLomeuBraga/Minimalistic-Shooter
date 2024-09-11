extends Node3D



func _ready() -> void:
	pass

@export var to_open : int = 0
@export var text : String = "ITEM"

var hight : float = 0
func _physics_process(delta: float) -> void:
	if to_open == 0:
		hight += delta
		$MeshInstance3D/Label3D.text = ""
	else:
		hight -= delta
		$MeshInstance3D/Label3D.text = text + "\n" + str(to_open)
	
	hight = max(0.0,min(1.0,hight))
	$MeshInstance3D.position.y = (hight * -7.0 ) + 3.0
	
	if to_open > 0 and $tutorial.visible and Input.is_action_just_pressed("use") and Global.player.shards > 0:
		to_open -= 1
		Global.player.shards -= 1
	
	if to_open == 0:
		$tutorial.visible = false


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == Global.player and to_open > 0:
		$tutorial.visible = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == Global.player:
		$tutorial.visible = false
