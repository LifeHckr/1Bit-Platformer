class_name Player_WallGrab extends Player_State

var stick : bool = true;
var timer : SceneTreeTimer = null;

func _phys(_delta : float) -> void:
	#
	player.velocity.y += player.gravity/2.5 * _delta;
	if Input.is_action_just_pressed("ui_accept") and player.is_on_wall() and player.canJump:
		player.velocity.y = player.JUMP_VELOCITY
		stick = false;
		player._change_state(player.state.WALLJUMP);
	elif player.x_direction == -1 * player.direction and stick and player.is_on_wall_only():
		player.velocity.y = 0;
	elif not player.is_on_wall_only():
		player._change_state(player.state.IDLE);
	
func _end_state() -> void:
	pass;

func _begin_state() -> void:
	player.velocity.y *= .75;
	player.sprite.play("wall_grab");
	player.stored_velo = player.velocity.x;
	stick = true;
	if timer != null:
		timer.timeout.disconnect(unstick);
	timer = player.get_tree().create_timer(1.0);
	timer.timeout.connect(unstick);
	if not player.ray.is_colliding():
		print_debug("Token")
		player.flip();


func unstick() -> void:
	stick = false;
