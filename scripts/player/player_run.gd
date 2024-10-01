class_name Player_Run extends Player_State

func _phys(_delta : float) -> void:
	player.checkTurn();
	player.velocity.y += player.gravity * _delta

	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor() and player.canJump:
		player.velocity.y = player.JUMP_VELOCITY
		player.audio.stream = player.jumpSound;
		player.audio.play();
	
	if player.is_on_wall_only() and player.can_wall_jump:
		player._change_state(player.state.WALLGRAB);
	elif player.x_direction != 0:
		player.velocity.x = player.x_direction * player.SPEED;
	else:
		player._change_state(player.state.IDLE);
	
func _end_state() -> void:
	pass

func _begin_state() -> void:
	player.sprite.play("run");
	player.current_anim = "run";
