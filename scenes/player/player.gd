extends CharacterBody2D

const MAX_SPEED = 200


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	
	# velocity is a property of charachterbody2d
	velocity = direction * MAX_SPEED
	
	# built in function that moves based on velocity
	# also returns excess velocity from collision
	move_and_slide()
	
	

func get_movement_vector() -> Vector2:
	
	# pressing a button on a keyboard is binary (on or off)
	# get action strength returns 1 or 0 if the key is pressed or not
	# if it was a stick it could be a fraction between them...
	
	# if right is pressed x movement is + 1 so move right
	# if left is pressed x movement is - 1 so move left
	# same for up and down
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	return Vector2(x_movement, y_movement)
