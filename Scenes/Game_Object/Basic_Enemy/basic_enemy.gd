extends CharacterBody2D

@onready var health_component: HealthComponent = $HealthComponent

const MAX_SPEED = 50
var player_node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_node = get_tree().get_first_node_in_group("Player") as Node2D
	$Area2D.area_entered.connect(on_area_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var direction = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()


func get_direction_to_player() -> Vector2:
	if (player_node != null):
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO


func on_area_entered(_area: Area2D):
	health_component.damage(10)
