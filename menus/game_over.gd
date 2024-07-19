class_name GameOver extends CanvasLayer

@onready var score_label: Label = %ScoreLabel
@onready var high_score_label: Label = %HighScoreLabel
@onready var restart_button: Button = %RestartButton
@onready var quit_button: Button = %QuitButton

func set_score(n:int) -> void:
	score_label.text = "Pontuação Final: " + str(n)
	if n > Global.save_data.high_score:
		high_score_label.visible = true
		Global.save_data.high_score = n
		Global.save_data.save()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_ENTER_TREE:
			get_tree().paused = true
		NOTIFICATION_EXIT_TREE:
			get_tree().paused = false



