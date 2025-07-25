extends Node

const SPAWN_RANGE = 380

@export var basic_enemy_scene: PackedScene

func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout() -> void:
	print("what?")
	var player_node = get_tree().get_first_node_in_group("Player") as Node2D
	if (player_node == null):
		return
	
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player_node.global_position + (random_direction * SPAWN_RANGE)
	
	var enemy_node = basic_enemy_scene.instantiate() as Node2D
	get_parent().add_child(enemy_node)
	enemy_node.global_position = spawn_position
	
