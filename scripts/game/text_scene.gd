extends Node2D

@onready var background : ParallaxBackground = get_node("%ParallaxBackground")
@onready var text : RichTextLabel = get_node("%RichTextLabel")
@onready var audio : AudioStreamPlayer = get_node("audio");
var speed : float = 50;
var direction : Vector2 = Vector2(0,1);
var timer : int = 0;
# Called when the node enters the scene tree for the first time.
func _ready():
	text.text = "[center]" + Global.text_scene_text + "[/center]";
	if Global.finished_questionmark:
		audio.play();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	background.scroll_offset += speed * delta * direction;
	timer += ceil(delta);
	if timer % 100 == 0:
		direction += direction.rotated(5 * (randf() - 5)).normalized();
		background.rotation = deg_to_rad(5 * (randf() - 5));
	
func _input(event) -> void:
	if event.is_action_pressed("next"):
		get_tree().change_scene_to_file(Global.text_scene_next_scene);
