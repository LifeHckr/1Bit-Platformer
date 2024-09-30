extends Area2D

@export var transition_to : String = "res://scenes/text_scene.tscn";
@export var override : Vector2 = Vector2.ZERO; #just don't ever need an override to be 0 :)


func _on_body_entered(_body: Node2D) -> void:
	get_tree().call_deferred("change_scene_to_file", transition_to);
	if override.x:
		Global.transition_coords.x = override.x;
	else:
		Global.transition_coords.x = _body.position.x;

	if override.y:
		Global.transition_coords.y = override.y;
	else:
		Global.transition_coords.y = _body.position.y;
