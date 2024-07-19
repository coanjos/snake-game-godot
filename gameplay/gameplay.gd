class_name Gameplay extends Node2D

@onready var head: Head = %Head as Head
@onready var bounds: Bounds = %Bounds as Bounds
@onready var spawner: Spawner = %Spawner as Spawner
@onready var hud: HUD = %HUD as HUD
@onready var camera: Camera = %Camera as Camera

const gameover_scene: PackedScene = preload("res://menus/game_over.tscn")
var gameover_menu: GameOver

const pausemenu_scene: PackedScene = preload("res://menus/pause_menu.tscn")
var pause_menu: PauseMenu

var time_between_moves: float = 1000.0
var times_since_last_move: float = 0
var speed: float = 2500.0
var move_dir: Vector2 = Vector2.RIGHT
var snake_parts: Array[SnakePart] = []
var score: int:
	get:
		return score
	set(value):
		score = value
		hud.update_score(value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	head.food_eaten.connect(_on_food_eaten)
	head.collided_with_tail.connect(_on_collided_with_tail)
	spawner.tail_added.connect(_on_tail_added)
	
	times_since_last_move = time_between_moves
	spawner.spawn_food()	
	snake_parts.push_back(head)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var new_dir: Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		new_dir = Vector2.UP		
	elif Input.is_action_pressed("ui_right"):
		new_dir = Vector2.RIGHT
	elif Input.is_action_pressed("ui_down"):
		new_dir = Vector2.DOWN
	elif Input.is_action_pressed("ui_left"):
		new_dir = Vector2.LEFT
		
	if new_dir + move_dir != Vector2.ZERO and new_dir != Vector2.ZERO:
		move_dir = new_dir
		
	if Input.is_action_just_pressed("ui_cancel"):
		pause_game()
		
func _physics_process(delta: float) -> void:
	times_since_last_move += delta * speed
	if times_since_last_move >= time_between_moves:
		update_snake()
		times_since_last_move = 0

func update_snake() -> void:
	var new_position: Vector2 = head.position + move_dir * Global.GRID_SIZE
	new_position = bounds.wrap_vector(new_position)
	head.move_to(new_position)
	
	for i in range(1, snake_parts.size(), 1):
		snake_parts[i].move_to(snake_parts[i-1].last_position)
	
func _on_food_eaten() -> void:
	var snake_last_position: Vector2 = snake_parts[snake_parts.size() - 1].last_position
	
	spawner.call_deferred("spawn_food")
	spawner.call_deferred("spawn_tail", snake_last_position)
	speed += 200
	score += 1	
	
func _on_tail_added(tail: Tail) -> void:
	snake_parts.push_back(tail)
	
func _on_collided_with_tail() -> void:	
	if not gameover_menu:
		gameover_menu = gameover_scene.instantiate() as GameOver
		add_child(gameover_menu)		
		gameover_menu.set_score(score)
		
	shake_camera()
		
func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_WINDOW_FOCUS_OUT:
		pause_game()

func pause_game() -> void:
	if not pause_menu:
		pause_menu = pausemenu_scene.instantiate() as PauseMenu
		add_child(pause_menu)
		
func shake_camera():
	camera.apply_shake()
