extends Node

const MAX_RANGE = 150
@export var sword_ability : PackedScene

var damage = 5
var base_wait_time

func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)
	base_wait_time = $Timer.wait_time
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


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
	
	var sword_instance = sword_ability.instantiate() as SwordAbility
	var foreground_layer = get_tree().get_first_node_in_group("Foreground_Layer")
	foreground_layer.add_child(sword_instance)
	sword_instance.hitbox_component.damage = damage
	sword_instance.global_position = enemy_nodes[0].global_position
	#4 is the offset. we need this so that enemy and sword position isn't the same so that
	#we can calculate the angles of the sword that will face the enemy.
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4 
	
	var sword_direction = enemy_nodes[0].global_position - sword_instance.global_position
	sword_instance.rotation = sword_direction.angle()


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if(upgrade.id != "sword_atk_rate"):
		return
	
	var percentage = current_upgrades[upgrade.id]["quantity"] * 0.1
	$Timer.wait_time = base_wait_time * (1- percentage)
	$Timer.start()
