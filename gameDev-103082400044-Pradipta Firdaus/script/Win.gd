extends Area2D


func _on_body_entered(body: Node2D) -> void:
	$"../TransitionScreen".show()
	$"../TransitionScreen".get_node("AnimationPlayer").play("fade_to_black")
