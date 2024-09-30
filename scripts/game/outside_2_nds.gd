extends Node2D

@onready var camera : Camera2D = get_node("camera");
@onready var player : Player = get_node("Dude");
@onready var text : RichTextLabel = get_node("%Text");

func _ready() -> void:
	player.position = Global.transition_coords;

func _process(_delta: float) -> void:
		camera.offset.y = 180 + 360 * (ceil(player.position.y / 360) - 1);


func _on_area_2d_body_entered(_body: Node2D) -> void:
	text.text = "[center]" + "Hey, I built the tower. But I didn't expect anyone to get this far, so I stopped. If you want more say something."
	player.process_mode = Node.PROCESS_MODE_DISABLED;
	Global.finished_questionmark = true;
	var timer1 : SceneTreeTimer = get_tree().create_timer(4);
	await timer1.timeout;
	text.text = "[center]" + "If you got here, I guess I should give you an ending."
	var timer2 : SceneTreeTimer = get_tree().create_timer(3);
	await timer2.timeout;
	Global.text_scene_text = "You did it, you did a YACTT:YFBE. Good End."
	get_tree().call_deferred("change_scene_to_file", "res://scenes/text_scene.tscn");
