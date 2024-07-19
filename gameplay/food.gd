class_name Food extends Node2D

@export var textures: Array[Texture]

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite_2d.texture = textures.pick_random()	
