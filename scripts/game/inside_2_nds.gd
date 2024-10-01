extends Node2D

@onready var camera : Camera2D = get_node("camera");
@onready var player : Player = get_node("Dude");
@onready var text : RichTextLabel = get_node("%Text");

func _ready() -> void:
	player.position = Global.transition_coords;
	Global.checkpoint_pos = player.position;

func _process(_delta: float) -> void:
		camera.offset.y = 180 + 360 * (ceil(player.position.y / 360) - 1);


func _on_essence_de_tetris_body_entered(_body: Node2D) -> void:
	if Global.constrols2:
		Global.constrols2 = false;
		var spritey : Area2D = load("res://scenes/fade_away_sprite.tscn").instantiate();
		spritey.position.y = player.position.y - 40;
		spritey.position.x = player.position.x;
		spritey.texture = load("res://sprites/arrows.png");
		spritey.input_based = true;
		get_tree().get_root().call_deferred("add_child", spritey);
		
	player.can_platty = true;
	player.audio.stream = player.pickupSound;
	player.audio.play();
	text.text = "[center]" + "Unlimited power (almost)."
