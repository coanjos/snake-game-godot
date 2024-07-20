class_name Tail extends SnakePart

@onready var animation_player = $AnimationPlayer

func _process(_delta):
	tail_direction(current_direction)

func tail_direction(direction: Vector2):
	last_direction = current_direction
	
	match direction:
		Vector2.RIGHT:
			animation_player.play("right")
		Vector2.LEFT:
			animation_player.play("left")			
		Vector2.UP:
			animation_player.play("up")
		Vector2.DOWN:
			animation_player.play("down")
			
			
			
	
