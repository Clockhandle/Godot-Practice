extends Node

const MAX_RANGE = 150
@export var sword_ability : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func on_timer_timeout() -> void:
	var player_node = get_tree().get_first_node_in_group("Player") as Node2D
	if (player_node == null):
		return
		
	var enemy_nodes = get_tree().get_nodes_in_group("Enemy")
	enemy_nodes = enemy_nodes.filter(func(enemy: Node2D):
		return enemy.global_position.distance_squared_to(player_node.global_position) < pow(MAX_RANGE, 2)
	)
	
	if (enemy_nodes.size() == 0):
		return
	
	enemy_nodes.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(player_node.global_position)
		var b_distance = b.global_position.distance_squared_to(player_node.global_position)
		return a_distance < b_distance
	)
	
	var sword_instance = sword_ability.instantiate() as Node2D
	player_node.get_parent().add_child(sword_instance)
	sword_instance.global_position = enemy_nodes[0].global_position
	#4 is the offset. we need this so that enemy and sword position isn't the same so that
	#we can calculate the angles of the sword that will face the enemy.
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4 
	
	var sword_direction = enemy_nodes[0].global_position - sword_instance.global_position
	sword_instance.rotation = sword_direction.angle()
	
	
