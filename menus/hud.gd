class_name HUD extends CanvasLayer

@onready var score: Label = $Panel/HBoxContainer/MarginContainer/Score
@onready var high_score: Label = $Panel/HBoxContainer/MarginContainer2/HighScore

func _ready() -> void:
	high_score.text = "Mais Alta: " + str(Global.save_data.high_score)

func update_score(n: int) -> void:
	score.text = "Pontuação: " + str(n)
