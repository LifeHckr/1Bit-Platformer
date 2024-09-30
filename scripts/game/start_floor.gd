extends Node2D

@onready var player : Player = get_node("Dude");
@onready var text : RichTextLabel = get_node("%Text");

func _ready() -> void:
	if Global.second_floors:
		player.position.x = Global.transition_coords.x;
		player.position.y = 21;
	if Global.finished_questionmark:
		text.text = "[center]" + "The game is over?";
	elif Global.can_wall_jump:
		text.text = "[center]" + "The game isn't over.";
