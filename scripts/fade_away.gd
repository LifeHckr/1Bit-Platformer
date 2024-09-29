extends Area2D

@onready var sprite : Sprite2D = get_node("%Node2D");
@export var texture : CompressedTexture2D = null;
var timer : float = 0;
var input_based : bool = false;

func _ready() -> void:
	sprite.texture = texture;

func _process(delta):
	timer += delta * 8;
	self.position.y += sin(timer) / 2;

func _input(event) -> void:
	if input_based && event.is_action_pressed("check"):
		fade();

func fade() -> void:
	var tween : Tween = create_tween();
	tween.tween_property(self, "modulate", Color(0, 0, 0, 0), .3);
	tween.tween_callback(self.queue_free);
	tween.play();

func _on_body_entered(_body : Node2D):
	if !input_based:
		fade();
