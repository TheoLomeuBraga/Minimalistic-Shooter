extends GenericPathFinder


var damage_color_time := 0.0
var original_color : Color

func _ready() -> void:
	look_mode = 1
	original_color = $MeshInstance3D.get_surface_override_material(0).albedo_color

@export var health := 20

@export var explosion_sceane : PackedScene



func hit_damage(damage : int) -> void:
	
	health -= damage
	damage_color_time = 0.25
	if health < 0:
		queue_free()
		var explosion : Node3D = explosion_sceane.instantiate()
		get_tree().get_root().add_child(explosion)
		explosion.global_position = global_position
	

func manage_damage(delta: float):
	damage_color_time -= delta
	if damage_color_time < 0:
		damage_color_time = 0
	
	var material : Material = $MeshInstance3D.get_surface_override_material(0)
	if damage_color_time > 0:
		material.albedo_color = lerp(original_color,Color.RED,damage_color_time * 4) 
	else:
		material.albedo_color = original_color
	$MeshInstance3D.set_surface_override_material(0,material)

func movement_plugin(delta: float) -> void:
	target_location = Global.player.global_position
	go = global_position.distance_to(Global.player.global_position) > 5
	if go:
		look_mode = 1
	else:
		look_mode = 2
	
	manage_damage(delta)
	
