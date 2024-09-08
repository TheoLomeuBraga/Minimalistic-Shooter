extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



func _process(delta: float) -> void:
	$CenterContainer/VBoxContainer/volume_display/volume_display.text = str($CenterContainer/VBoxContainer/volume_slider.value)
	AudioServer.set_bus_volume_db(0,($CenterContainer/VBoxContainer/volume_slider.value * 0.8) - 40)
	
	$CenterContainer/VBoxContainer/sensitivity/sensitivity_display.text = str($CenterContainer/VBoxContainer/sensitivity_slider.value)
	Global.mouse_sensitivity = $CenterContainer/VBoxContainer/sensitivity_slider.value
	Global.joystick_sensitivity = $CenterContainer/VBoxContainer/sensitivity_slider.value



func _on_button_button_down() -> void:
	get_tree().quit()


func _on_visibility_changed() -> void:
	$CenterContainer/VBoxContainer/volume_slider.grab_focus()
