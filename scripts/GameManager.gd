extends Node3D

var paused:bool = false
@export var nextLevel:String

@onready var paused_screen = $"../UI/PausedScreen"
@onready var button = $"../UI/Button"
@onready var lose_screen = $"../UI/LoseScreen"
@onready var win_screen = $"../UI/winScreen"
@onready var loseAnim = $"../UI/LoseScreen/AnimationPlayer"
@onready var winAnim = $"../UI/winScreen/AnimationPlayer"

func _ready():
	if OS.get_name() == 'Windows':
		button.visible = false
	
func _input(_event):
	if Input.is_key_pressed(KEY_ESCAPE):
		pauseControl()

func _on_restart_pressed():
	get_tree().paused = false
	Engine.time_scale = 1
	get_tree().reload_current_scene()

func _on_button_pressed():
	pauseControl()
	
func pauseControl():
	paused = !paused
	get_tree().paused = paused
	paused_screen.visible = paused
	if OS.get_name() != 'Windows':
		button.visible = !paused


func _on_player_collision():
	lose_screen.visible = true
	loseAnim.speed_scale = 1 / Engine.time_scale
	loseAnim.play("Fade In")


func _on_animation_player_animation_finished(_anim_name):
	get_tree().paused = true


func _on_player_game_won():
	win_screen.visible = true
	winAnim.speed_scale = 1 / Engine.time_scale
	winAnim.play("Fade In")


func _on_next_level_pressed():
	get_tree().paused = false
	Engine.time_scale = 1
	get_tree().change_scene_to_file('res://scenes/Level ' + nextLevel + '.tscn')
