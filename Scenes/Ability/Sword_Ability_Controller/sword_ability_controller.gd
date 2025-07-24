extends Node

@export var sword_ability : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_timer_timeout() -> void:
	var player_node = get_tree().get_first_node_in_group("Player") as Node2D
	if (player_node == null):
		return
	
	var sword_instance = sword_ability.instantiate() as Node2D
	player_node.get_parent().add_child(sword_instance)
	sword_instance.global_position = player_node.global_position
	
