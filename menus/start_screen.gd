class_name StartScreen extends CanvasLayer

@onready var score_label: Label = %ScoreLabel
@onready var start_button: Button = %StartButton
@onready var quit_button: Button = %QuitButton

const gameplay_scene: PackedScene = preload("res://gameplay/gameplay.tscn")

func _ready() -> void:
	var high_score: int = Global.save_data.high_score
	score_label.text = "Pontuação mais alta: " + str(high_score)

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(gameplay_scene)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
