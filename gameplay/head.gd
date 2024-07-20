class_name Head extends SnakePart

@onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer

signal food_eaten
signal ultraprocessed_food_eaten
signal collided_with_tail

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("food"):
		food_eaten.emit()
		area.call_deferred("queue_free")
	elif area.is_in_group("ultraprocessed_food"):
		ultraprocessed_food_eaten.emit()
		area.call_deferred("queue_free")
	else:
		collided_with_tail.emit()

func head_direction(direction: Vector2):
	match direction:
		Vector2.RIGHT:
			animation_player.play("right")
		Vector2.LEFT:
			animation_player.play("left")			
		Vector2.UP:
			animation_player.play("up")
		Vector2.DOWN:
			animation_player.play("down")
			
	last_direction = direction
			
			
