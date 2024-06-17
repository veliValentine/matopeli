extends Area2D

@export var velocity = Vector2(1,0)
@export var speed = 200
@export var turn_speed = PI / 180 * 3

@export var left_turn_action = "p1_left"
@export var right_turn_action = "p1_right"

var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
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
	clamp_to_screen()
	

func clamp_to_screen():
	if position.x > screen_size.x:
		position.x = 0
	if position.x < 0:
		position.x = screen_size.x
	if position.y > screen_size.y:
		position.y = 0
	if position.y <0:
		position.y = screen_size.y
