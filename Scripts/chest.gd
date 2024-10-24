extends Node2D 
@onready var anim = $anim
var is_open = false
var player

func _ready() -> void:
	anim.play("Closed")
	player = Global.global_player


func _on_ChestArea_body_entered(body: Node2D) -> void:
	if body.name == "player" and not is_open:
		anim.play("Open")
		is_open = true  


func _on_ChestArea_body_exited(body: Node2D) -> void:
	if body.name == "player" and is_open:
		anim.play("Closed")
