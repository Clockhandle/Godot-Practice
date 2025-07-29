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


func on_timer_timeout() -> void:
	timer.start()
	
	var player_node = get_tree().get_first_node_in_group("Player") as Node2D
	if (player_node == null):
		return
	
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player_node.global_position + (random_direction * SPAWN_RANGE)
	
	var enemy_node = basic_enemy_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("Entities_Layer")
	entities_layer.add_child(enemy_node)
	enemy_node.global_position = spawn_position


func on_arena_difficulty_increased(arena_difficulty: int):
	var time_off = (0.1/12) * arena_difficulty
	time_off = min (time_off, 0.7)
	print(time_off)
	timer.wait_time = base_wait_time - time_off
