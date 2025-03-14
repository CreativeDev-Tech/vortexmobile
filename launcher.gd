extends Node2D

# Declare the Label node
@onready var label = $Label

# Timer intervals for the different states
var timing = [
	{ "text": "Launching...", "delay": 4 },
	{ "text": "Checking Connection...", "delay": 5 },
	{ "text": "Loading Menu...", "delay": 3 },
	{ "text": "Loading Interface...", "delay": 1 },
	{ "text": "Loading UI...", "delay": 4 },
	{ "text": "Preparing Services...", "delay": 6 },
	{ "text": "Launching...", "delay": 7 }
]

# Function to handle the "..." pattern
func get_ellipsis_pattern(base_text: String) -> String:
	var dots = base_text.substr(base_text.length() - 3, 3)
	var pattern = ""
	
	# Determine the next ellipsis pattern in the sequence: ".", "..", "..."
	if dots == "...":
		pattern = "."
	elif dots == ".":
		pattern = ".."
	elif dots == "..":
		pattern = "..."
	
	return pattern

# Function to cycle the ellipsis only while keeping the base text unchanged
func cycle_ellipsis(new_text: String, cycle_duration: float) -> void:
	var cycle_timer = 0.0
	var base_text = new_text.substr(0, new_text.length() - 3)  # Get the base text without the ellipsis
	var ellipsis = "..."
	
	# Start cycling the ellipsis every 0.1 seconds
	while cycle_timer < cycle_duration:
		# Set the label's text with the base text + current ellipsis pattern
		label.text = base_text + ellipsis
		# Wait for 0.1 seconds before updating the ellipsis
		await get_tree().create_timer(0.1).timeout  # Wait for 0.1 seconds
		cycle_timer += 0.1
		# Update ellipsis pattern
		ellipsis = get_ellipsis_pattern(base_text + ellipsis)
	
	# Ensure the final text after cycling
	label.text = new_text

# _ready is called when the node is added to the scene
func _ready():
	var i = 0
	while i < timing.size():
		var current = timing[i]
		# Call the update function for the label text with the delay and cycling time
		cycle_ellipsis(current["text"], current["delay"])
		# Wait for the delay before continuing to the next text
		await get_tree().create_timer(current["delay"]).timeout  # Wait for the text change delay
		i += 1
