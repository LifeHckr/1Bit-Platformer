extends Area2D

@export var speed : float = 100;
@export var dir : Vector2 = Vector2.ZERO;
var lifespan : float = 10;

func _process(_delta) -> void:
	self.position += speed * dir;
	lifespan -= _delta;
	if lifespan <= 0:
		queue_free();

func _on_body_entered(body : Node2D):
	if body.is_in_group("player"):
		body.death();
	queue_free();
