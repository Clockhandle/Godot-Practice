extends Node

signal experience_updated(current_experiece: float, target_experiece: float)

const TARGET_EXPERIENCE_GROWTH = 5

var current_experience = 0
var current_level = 1
var target_experience = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameEvents.experience_vial_collected.connect(on_experience_collected)


func increment_experience_count(number: float):
	current_experience = min(current_experience + number, target_experience)
	experience_updated.emit(current_experience, target_experience)
	if(current_experience == target_experience):
		current_level += 1
		target_experience += TARGET_EXPERIENCE_GROWTH
		current_experience = 0
		experience_updated.emit(current_experience, target_experience)


func on_experience_collected(number: float):
	increment_experience_count(number)
