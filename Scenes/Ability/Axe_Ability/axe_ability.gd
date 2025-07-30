extends Node2D

const MAX_RADIUS = 150

@onready var hitbox_component = $HitboxComponent

var base_rotation = Vector2.ZERO


func _ready() -> void:
	base_rotation = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var tween = create_tween()
	tween.tween_method(tween_method, 0.0, 2.0, 3)
	tween.tween_callback(queue_free)


func tween_method(rotations: float):
	var percentage = rotations / 2
	var current_radius = percentage * MAX_RADIUS
	var current_direction = base_rotation.rotated(rotations * TAU)
	
	var player_node = get_tree().get_first_node_in_group("Player") as Node2D
	if(player_node == null):
		return
	
	global_position = player_node.global_position + (current_direction * current_radius)
