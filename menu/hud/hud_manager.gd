extends CanvasLayer
class_name HUDManager

@onready var upgrades_menu: UpgradesSelectionMenu = $UpgradesSelectionMenu
@onready var hud: HUD = $HUD

func _ready() -> void:
	upgrades_menu.visible = false

	Events.on_upgrade_selected.connect(hide_upgrades_menu)

func show_upgrades_menu() -> void:
	upgrades_menu.refresh_upgrade_cards()
	upgrades_menu.visible = true

func hide_upgrades_menu() -> void:
	upgrades_menu.clear_upgrade_cards()
	upgrades_menu.visible = false
