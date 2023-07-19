extends CharacterBody2D

const MAX_SPEED = 40


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# reference area 2d in basic enemy node
	# connect to the area entered signal
	# define callback
	$Area2D.area_entered.connect(on_area_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()


func get_direction_to_player():
	var player_node = get_tree().get_first_node_in_group("player")
	
	if player_node != null:
		return (player_node.global_position - global_position).normalized()
	
	return Vector2.ZERO


func on_area_entered(other_area: Area2D):
	# at apropriate time remove node from scene tree and memory
	queue_free()
