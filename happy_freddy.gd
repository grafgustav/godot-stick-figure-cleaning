class_name HappyFreddy
extends AnimatedSprite2D

func play_idle_animation():
	%AnimationPlayer.play("idle")

func play_walk_animation():
	%AnimationPlayer.play("walk")

func play_brooming_animation():
	%AnimationPlayer.play("brooming")
