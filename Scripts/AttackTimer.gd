extends Timer

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()


func _on_timeout():
	print("boss attack!")
	wait_time = rng.randi_range(10,20)
