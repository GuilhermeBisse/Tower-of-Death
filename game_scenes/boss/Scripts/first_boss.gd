extends Node2D

var health = 100
var max_health = 100
@export var lower_health_color: Color
@onready var hands = $Hands
@onready var sprite = $AnimatedSprite2D


func _process(delta):
	color_based_on_health()
	if health <= 0:
		queue_free()

func color_based_on_health():
	var value = remap(health,0,max_health,0,1)
	sprite.modulate = lerp(lower_health_color,Color.WHITE,value)
	hands.modulate = lerp(lower_health_color,Color.WHITE,value)


func _on_hands_damaged():
	health-=10
