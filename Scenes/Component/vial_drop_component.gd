extends Node

@export_range(0, 1) var vial_spawn_chance: float = 0.5
@export var health_component: Node
@export var exp_vial_scene: PackedScene

var exp_vial_instance 
func _ready() -> void:
	(health_component as HealthComponent).died.connect(on_death)
	if(exp_vial_scene == null):
		print("No Vial Scene bruh")
	exp_vial_instance = exp_vial_scene.instantiate() as Node2D


func on_death():
	if(randf() > vial_spawn_chance):
		return
	
	if(not owner is Node2D):
		return
	
	var spawn_position = (owner as Node2D).global_position
	owner.get_parent().add_child(exp_vial_instance)
	exp_vial_instance.global_position = spawn_position
