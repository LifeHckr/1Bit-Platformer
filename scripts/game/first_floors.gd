extends Node2D
@onready var text : RichTextLabel = get_node("%Text");
@onready var camera : Camera2D = get_node("%camera");
@onready var player : CharacterBody2D = get_node("%Dude");

# Called when the node enters the scene tree for the first time.
func _ready():
	player.position = Global.transition_coords;
	Global.checkpoint_pos = player.position;
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	camera.offset.y = 180 + 360 * (ceil(player.position.y / 360) - 1);

func _jump_obtained(_body : Node2D) -> void:
	text.text = "[center]" + "Press W to jump!";
	Global.canJump = true;
	player.canJump = true;
	player.audio.stream = player.pickupSound;
	player.audio.play();

func _glue_obtained(_body : Node2D) -> void:
	text.text = "[center]" + "Sticky >:)";
	Global.can_wall_jump = true;
	player.can_wall_jump = true;
	player.audio.stream = player.pickupSound;
	player.audio.play();


func _checkpoint_1(_body : Node2D):
	text.text = "[center]" + "Checkpoint get!!! O_O WOW";
