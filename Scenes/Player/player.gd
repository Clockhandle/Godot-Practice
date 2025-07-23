extends CharacterBody2D

const MAX_PLAYER_SPEED = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var movement_vector = get_player_movement_vector()
	var direction = movement_vector.normalized()
	velocity = direction * MAX_PLAYER_SPEED
	move_and_slide()

func get_player_movement_vector() -> Vector2:
	var x_movement = Input.get_action_strength("player_move_right") - Input.get_action_strength("player_move_left")
	var y_movement = Input.get_action_strength("player_move_down") - Input.get_action_strength("player_move_up")
	return Vector2(x_movement, y_movement)
