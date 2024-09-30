extends Area2D

@onready var sprite : Sprite2D = get_node("%Node2D");
@export var texture : CompressedTexture2D = null;
@export var flag : String = "";

var timer : float = 0;
@export var input_based : bool = false;

func _ready() -> void:
	if Global.get(flag):
		self.queue_free();
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
	Global.set(flag, true);
		
		

func _on_body_entered(_body : Node2D):
	self.set_collision_layer_value(1, false);
	if !input_based:
		fade();
