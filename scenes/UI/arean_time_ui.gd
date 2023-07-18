extends CanvasLayer

# allows you to reference a node in the scene tree
# the time manager node will go in here
@export var arena_time_manager: Node
@onready var label = $%Label


func _process(delta: float):
	if arena_time_manager == null:
		return
	
	# get time elapsed and assign it to lable in ui node
	var time_elapsed = arena_time_manager.get_time_elapsed()
	label.text = format_seconds_to_string(time_elapsed)


func format_seconds_to_string(seconds: float): 
	var minutes = floor(seconds / 60)
	var remaining_seconds = seconds - (minutes * 60)
	# format string fixes leading zero problem
	# there similar to regex
	return str(minutes) + ":" + ("%02d" % floor(remaining_seconds))
