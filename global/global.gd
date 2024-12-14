extends Node

var global_player: CharacterBody2D
var current_camera: Camera2D


func freeze_time(timeScale, duration):
	Engine.time_scale = timeScale
	await get_tree().create_timer(duration,true,false,true).timeout
	Engine.time_scale = 1
