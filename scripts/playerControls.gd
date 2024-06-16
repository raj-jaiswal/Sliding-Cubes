extends RigidBody3D

var vel: float = 100;
@export var speed: float = 5;
@export var forwardSpeed: float = 5;
@export var rate: float = 1;

var score:float = 0
var gameOver:bool = false
signal collision
signal gameWon
@onready var label = $"../UI/Label"
@onready var collisionAudio = $"../Audio/collision"
@onready var background = $"../Audio/background"

func _process(_delta):
	label.text = str(round(score))

func _physics_process(delta):
	apply_central_impulse(Vector3(0, 0, forwardSpeed * delta))
	if Input.is_action_pressed("left"):
		apply_central_impulse(Vector3(speed * delta, 0, 0))
	if Input.is_action_pressed("right"):
		apply_central_impulse(Vector3(-speed * delta, 0, 0))
	
	forwardSpeed += rate * delta;
	if !gameOver:
		score += delta * speed * 0.4


func _on_area_3d_body_entered(_body):
	Engine.time_scale = 0.2
	collided(false)

func _on_obstacle_body_entered(body):
	if body == self:
		Engine.time_scale = 0.3
		collided()

func collided(playSound = true):
	if gameOver == false and playSound:
		collisionAudio.play()
	gameOver = true
	background.volume_db = -30
	collision.emit()
	
	
func _on_win_collider_body_entered(_body):
	if _body == self:
		gameWon.emit()
