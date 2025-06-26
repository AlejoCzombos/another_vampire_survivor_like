extends Node

signal on_enemy_died(global_position: Vector2)
signal on_enemy_hit()

signal on_player_hit()
signal on_player_died()
signal on_level_up()
signal on_experience_collected()

signal on_upgrade_selected()

# HUD
signal hud_refresh_experience(experience: int)
signal hud_refresh_level(new_level: int, new_experience_required: int)
signal hud_refresh_health(health: int)
signal hud_refresh_max_health(current_health: int, max_health: int)