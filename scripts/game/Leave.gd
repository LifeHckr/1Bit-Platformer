extends Area2D

#func _ready() -> void:
	#body_entered.emit(self);

func _on_body_entered(_body : Node2D) -> void:
	Global.text_scene_text = "You left, bye bye. Bad End."
	get_tree().call_deferred("change_scene_to_file", "res://scenes/text_scene.tscn");
