extends Node

signal enemy_died(global_position: Vector2)
signal enemy_hit()

signal player_hit()
signal experience_collected()

# HUD
signal hud_refresh_experience()
signal hud_refresh_health()
