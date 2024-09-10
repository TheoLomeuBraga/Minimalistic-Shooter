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
