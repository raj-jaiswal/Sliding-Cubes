extends Camera3D

@onready var player = $"../Player"

@export var offset:Vector3 = Vector3();
@export var lim:float = 5;

func _process(_delta):
	position = player.position + offset

func constraint(value, lower, upper):
	if value<lower:
		value = lower
	if value > upper:
		value = upper
	return value
