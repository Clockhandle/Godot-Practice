extends Node

var current_experience = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.experience_vial_collected.connect(on_experience_collected)


func increment_experience_count(number: float):
	current_experience += number
	print(current_experience)


func on_experience_collected(number: float):
	increment_experience_count(number)
