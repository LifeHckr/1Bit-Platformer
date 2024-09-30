extends StaticBody2D

var timer : SceneTreeTimer;

func _ready() -> void:
	timer = self.get_tree().create_timer(.75);
	timer.timeout.connect(phase);

func phase() -> void:
	set_collision_layer_value(1, false);
	set_collision_layer_value(2, false);
	set_collision_mask_value(1, false);
	var tween : Tween = create_tween();
	tween.tween_property(self, "modulate", Color(0, 0, 0, 0), .3);
	tween.tween_callback(self.queue_free);
	tween.play();
