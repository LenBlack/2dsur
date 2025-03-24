extends CanvasLayer


func _ready() -> void:
	get_tree().paused = true
	$%RestarButton.pressed.connect(on_restartbutton_pressed)
	$%QuitButton.pressed.connect(on_quit_button_pressed)
	
func on_restartbutton_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Main/Main.tscn")
	
func on_quit_button_pressed():
	get_tree().quit()
	
	
