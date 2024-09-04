extends GenericPathFinder

@export var health := 20

@export var explosion_sceane : PackedScene

@export var array_meshes_display_damage : Array[MeshInstance3D]
var damage_color_time := 0.0

func hit_damage(damage : int):
	health -= damage
	damage_color_time = 0.25
	if health < 0:
		queue_free()
		var explosion : Node3D = explosion_sceane.instantiate()
		get_tree().get_root().add_child(explosion)
		explosion.global_position = global_position

func manage_damage(delta: float) -> void:
	
	if damage_color_time < 0:
		damage_color_time = 0
	
	for mi in array_meshes_display_damage:
		var material : Material = mi.get_surface_override_material(0)
		if material == null:
			material = mi.mesh.surface_get_material(0)
		if damage_color_time > 0:
			material.emission = lerp(Color.BLACK,Color.WHITE,damage_color_time * 4) 
		else:
			material.emission = Color.BLACK
		mi.set_surface_override_material(0,material)
	damage_color_time -= delta



func _init() -> void:
	look_mode = 1


func movement_plugin(delta: float) -> void:
	target_location = Global.player.global_position
	go = global_position.distance_to(target_location) > 2
	manage_damage(delta)
