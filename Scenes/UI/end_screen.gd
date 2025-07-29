extends CanvasLayer

@onready var restart_button = %RestartButton
@onready var quit_button = %QuitButton


func _ready() -> void:
	get_tree().paused = true
	restart_button.pressed.connect(on_restart_pressed)
	quit_button.pressed.connect(on_quit_pressed)


func set_defeat():
	%TitleLabel.text = "Defeat"
	%DescriptionLabel.text = "You Lost!"


func on_restart_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Main/main.tscn")


func on_quit_pressed():
	get_tree().quit()
