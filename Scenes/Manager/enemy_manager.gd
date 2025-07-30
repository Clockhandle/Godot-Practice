extends Node

const SPAWN_RANGE = 380

@export var basic_enemy_scene: PackedScene
@export var arena_time_manager: Node

@onready var timer = $Timer

var base_wait_time

func _ready() -> void:
	base_wait_time = timer.wait_time
	timer.timeout.connect(on_timer_timeout)
	arena_time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)


func get_spawn_position():
	var player_node = get_tree().get_first_node_in_group("Player") as Node2D
	if (player_node == null):
		return
	
	#Get ray to cast from 4 directions. Only spawn enemies when ray doesn't hit anything
	#results in enemies not spawning outside the wall we've set
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = Vector2.ZERO
	for i in 4:
		spawn_position = player_node.global_position + (random_direction * SPAWN_RANGE)
		var query_params = PhysicsRayQueryParameters2D.create(player_node.global_position, spawn_position, 1)
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_params)
		
		if(result.is_empty()):
			break
		else:
			random_direction = random_direction.rotated(deg_to_rad(90))
	
	return spawn_position


func on_timer_timeout() -> void:
	timer.start()
	
	var player_node = get_tree().get_first_node_in_group("Player") as Node2D
	if (player_node == null):
		return
	
	var enemy_node = basic_enemy_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("Entities_Layer")
	entities_layer.add_child(enemy_node)
	enemy_node.global_position = get_spawn_position()


func on_arena_difficulty_increased(arena_difficulty: int):
	var time_off = (0.1/12) * arena_difficulty
	time_off = min (time_off, 0.7)
	print(time_off)
	timer.wait_time = base_wait_time - time_off
