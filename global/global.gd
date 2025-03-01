extends Node

var global_player: CharacterBody2D
var current_camera: Camera2D
var key_picked: bool = false
var dash_picked: bool = false
var is_player_dead: bool = false
var player_health: int = 100

# ------------------------ #
# DEATH DIALOGUE VARIABLES #
# ------------------------ #

var death_encounters = 0;
var dead_count = 0;
var is_talking = false


func freeze_time(timeScale, duration):
	Engine.time_scale = timeScale
	await get_tree().create_timer(duration,true,false,true).timeout
	Engine.time_scale = 1
