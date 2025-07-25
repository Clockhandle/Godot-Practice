extends Camera2D

var target_position = Vector2.ZERO
var player_nodes
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_current()
	player_nodes = get_tree().get_nodes_in_group("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	acquire_target()
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 10))


func acquire_target() -> void:
	if player_nodes.size() > 0:
		var player = player_nodes[0] as Node2D
		target_position = player.global_position
