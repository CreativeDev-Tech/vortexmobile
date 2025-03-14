extends Node2D

# Reference to the AnimationPlayer
@onready var animation_player = $AnimationPlayer

# Fade Out and Fade In animation names
var fade_out_animation = "Fade_Out"
var fade_in_animation = "Fade_In"

# The path of the scene you want to switch to
var next_scene_path = "res://Launcher.tscn"  # Path to your Launcher scene

# _ready is called when the node is added to the scene
func _ready():
	# Play the Fade_Out animation
	animation_player.play(fade_out_animation)
	
	# Wait for 4 seconds before playing the Fade_In animation
	await get_tree().create_timer(4.0).timeout
	
	# Play the Fade_In animation after 4 seconds
	animation_player.play(fade_in_animation)
	
	# Wait for 5 seconds after Fade_In animation before switching the scene
	await get_tree().create_timer(10.0).timeout
	
	# Change to the next scene (Launcher)
	get_tree().change_scene_to_file(next_scene_path)
