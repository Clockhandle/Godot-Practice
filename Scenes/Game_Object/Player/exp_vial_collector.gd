extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.area_entered.connect(on_area_entered)


func on_area_entered(exp_vial: Area2D):
	GameEvents.emit_experience_vial_collected(1)
	exp_vial.get_parent().queue_free()
