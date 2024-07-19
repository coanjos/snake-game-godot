class_name Spawner extends Node2D

signal tail_added(tail: Tail)

@export var bounds:Bounds

var food_scene: PackedScene = preload("res://gameplay/food.tscn")
var tail_scene: PackedScene = preload("res://gameplay/tail.tscn")

func spawn_food() -> void:
	var spawn_point: Vector2 = Vector2.ZERO
	spawn_point.x = randf_range(bounds.x_min + Global.GRID_SIZE, bounds.x_max - Global.GRID_SIZE)
	spawn_point.y = randf_range(bounds.y_min + Global.GRID_SIZE, bounds.y_max - Global.GRID_SIZE)
	
	spawn_point.x = floor(spawn_point.x / Global.GRID_SIZE) * Global.GRID_SIZE
	spawn_point.y = floor(spawn_point.y / Global.GRID_SIZE) * Global.GRID_SIZE
	
	var food: Food = food_scene.instantiate()
	
	food.position = spawn_point
	
	get_parent().add_child(food)
	
func spawn_tail(pos: Vector2) -> void:
	var tail: Tail = tail_scene.instantiate() as Tail
	tail.position = pos
	get_parent().add_child(tail)
	tail_added.emit(tail)
