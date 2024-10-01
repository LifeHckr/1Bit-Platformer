extends StaticBody2D

var timer : SceneTreeTimer;
var web_fix_cast : ShapeCast2D = null;

func _ready() -> void:
	timer = self.get_tree().create_timer(.75);
	timer.timeout.connect(phase);
	web_fix_cast = get_node("web_fix");
	
func _physics_process(_delta: float) -> void:
	if web_fix_cast.is_colliding():
		print_debug("hello")
		var testee = web_fix_cast.get_collider(0);
		if testee is Area2D:
			testee.body_entered.emit(self);

func phase() -> void:
	set_collision_layer_value(1, false);
	set_collision_layer_value(2, false);
	set_collision_mask_value(1, false);
	var tween : Tween = create_tween();
	tween.tween_property(self, "modulate", Color(0, 0, 0, 0), .3);
	tween.tween_callback(self.queue_free);
	tween.play();
