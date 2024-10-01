class_name Player_Idle extends Player_State

func _phys(_delta : float) -> void:

	player.velocity.y += player.gravity * _delta

	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor() and player.canJump:
		player.audio.stream = player.jumpSound;
		player.audio.play();
		player.velocity.y = player.JUMP_VELOCITY

	var direction : float = Input.get_axis("ui_left", "ui_right");
	if player.is_on_wall_only() and player.can_wall_jump:
		player._change_state(player.state.WALLGRAB);
	elif direction:
		player._change_state(player.state.WALK);
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED/10);
	
func _end_state() -> void:
	pass;

func _begin_state() -> void:
	player.sprite.play("idle");
	player.current_anim = "idle";
