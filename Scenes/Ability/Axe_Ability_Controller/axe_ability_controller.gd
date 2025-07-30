extends Node

@export var axe_ability_scene: PackedScene

var damage = 10


func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player_node = get_tree().get_first_node_in_group("Player") as Node2D
	if(player_node == null):
		return
	
	var foreground_node = get_tree().get_first_node_in_group("Foreground_Layer") as Node2D
	if(foreground_node == null):
		return
	
	var axe_ability_instance = axe_ability_scene.instantiate() as Node2D
	foreground_node.add_child(axe_ability_instance)
	axe_ability_instance.hitbox_component.damage = damage
	axe_ability_instance.global_position = player_node.global_position
	
