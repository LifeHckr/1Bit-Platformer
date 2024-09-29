extends Marker2D

@export var cooldown : float = 200;
@export var dir : Vector2 = Vector2.ZERO;
@export var speed : float = 0;
@export var n_rotation : float = 0;
var bullet : PackedScene = preload("res://scenes/small_things/bullet.tscn");
var timer : float = 0;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	timer += _delta;
	if timer >= cooldown:
		shoot();
		timer = 0;
		
func shoot() -> void:
	var new_bullet : Area2D = bullet.instantiate();
	new_bullet.speed = speed;
	new_bullet.rotation = deg_to_rad(n_rotation);
	new_bullet.dir = dir;
	add_child(new_bullet);
