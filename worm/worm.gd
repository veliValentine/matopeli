class_name Worm extends Area2D

@export var velocity = Vector2(1,0)
@export var speed = 200
@export var turn_speed = PI / 180 * 3
@export var left_turn_action = "left_1"
@export var right_turn_action = "right_1"

@export var color = Color(Color.WHITE)

@export var size = Vector2(8, 8)

@export var is_alive = true

@export var clamp = false

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	$ColorRect.size = size
	$ColorRect.color = color	
	$CollisionShape2D.shape.size = size

func _process(delta):
	var old_position = position
	if is_alive:
		handle_turns(delta)

func handle_turns(delta):
	var turn_direction = 0
	if Input.is_action_pressed(left_turn_action):
		turn_direction -= turn_speed
	if Input.is_action_pressed(right_turn_action):
		turn_direction += turn_speed
	
	velocity = velocity.rotated(turn_direction)
	velocity = velocity.normalized() * speed
	position += velocity * delta
	
	if clamp:
		position = position.clamp(Vector2.ZERO, screen_size)
	else:
		teleport_to_other_side()
	round_position()
	

func teleport_to_other_side():
	if position.x >= screen_size.x - size.x:
		position.x = 0
	if position.x < 0:
		position.x = screen_size.x - size.x
		
	if position.y >= screen_size.y - size.y:
		position.y = 0
	if position.y < 0:
		position.y = screen_size.y - size.y

func round_position():
	position.x = round(position.x)
	position.y = round(position.y)

func kill():
	is_alive = false

func get_panel():
	return $ColorRect
