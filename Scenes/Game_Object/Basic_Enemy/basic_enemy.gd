extends CharacterBody2D


const MAX_SPEED = 50
var player_node


func _ready() -> void:
	player_node = get_tree().get_first_node_in_group("Player") as Node2D


func _process(_delta: float) -> void:
	var direction = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()


func get_direction_to_player() -> Vector2:
	if (player_node != null):
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO
