extends Area2D




func _on_coin_body_entered(body):
	body.add_coin()
	$AnimationPlayer.play("bounce")


func _on_AnimationPlayer_animation_finished(anim_name):
	print(anim_name)
	if anim_name == "bounce":
		queue_free()
