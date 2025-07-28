extends CanvasLayer

@export var exp_manager: Node
@onready var progress_bar = %ProgressBar

func _ready() -> void:
	progress_bar.value = 0
	exp_manager.experience_updated.connect(on_experience_updated)


func on_experience_updated(current_experience: float, target_experience: float):
	var exp_percent = current_experience / target_experience
	progress_bar.value = exp_percent
