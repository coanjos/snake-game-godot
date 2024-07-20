extends Node

const GRID_SIZE: int = 32

var save_data: SaveData

func _ready() -> void:
	save_data = SaveData.load_or_create()

# TODO punições de comer coisa errada
# TODO animação e sprite melhor da cobra ou centopeia (talvez quebrar esta tarefa)
# TODO introdução do "ajude a cobrinha" com slide e depois "alimentos ruins causam punição"

# BUG spawn de comida no corpo
