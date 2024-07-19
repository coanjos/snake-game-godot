class_name SnakePart extends Node2D

var last_position: Vector2

func move_to(new_position: Vector2) -> void:
	last_position = self.position
	self.position = new_position
