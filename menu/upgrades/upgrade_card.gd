class_name UpgradeCard
extends NinePatchRect

@onready var title_label: RichTextLabel = $MarginContainer/VBoxContainer/Title
@onready var description_label: RichTextLabel = $MarginContainer/VBoxContainer/Description
@onready var icon_texture: TextureRect = $MarginContainer/VBoxContainer/Icon
@onready var info_label: RichTextLabel = $MarginContainer/VBoxContainer/Info

var upgrade_resource: UpgradeResource
var initial_position: Vector2
var tween_hover: Tween

var is_selected: bool = false
# TODO: Add validation to not allow multiple upgrades to be applied at once

func _ready() -> void:
	initial_position = position
	#position.y = initial_position.y + 20
	title_label.clear()
	description_label.clear()
	info_label.clear()
	icon_texture.texture = null


func set_upgrade(upgrade: UpgradeResource) -> void:
	upgrade_resource = upgrade
	icon_texture.texture = upgrade_resource.card_icon
	title_label.append_text("[wave amp=12.0 freq=4.0]" + upgrade_resource.card_title)
	description_label.append_text(upgrade_resource.card_description)
	info_label.append_text("[color=yellow]" + str(upgrade_resource.upgrade_value) + "[/color]")


func play_entrance(delay: float = 0.0) -> void:
	await get_tree().create_timer(delay).timeout
	
	modulate.a = 0
	#scale = Vector2(0.5, 0.5)
	#position.y = initial_position.y + 20

	var tween_entrance: Tween = get_tree().create_tween().set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween_entrance.tween_property(self, "modulate:a", 1.0, 0.2)
	#tween_entrance.tween_property(self, "scale", Vector2(1.0, 1.0), 0.2)
	tween_entrance.tween_property(self, "position:y", initial_position.y, 0.2).set_delay(0.1)
	# TODO: play a sound effect for the entrance animation



func _on_mouse_entered() -> void:
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	
	is_selected = true
	tween_hover = create_tween().set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween_hover.tween_property(self, "position:y", initial_position.y - 10, 0.1)


func _on_mouse_exited() -> void:
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	
	is_selected = false
	tween_hover = create_tween().set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween_hover.tween_property(self, "position:y", initial_position.y + 10, 0.1)


func _on_gui_input(event: InputEvent) -> void:
	if is_selected and event is InputEventMouseButton and event.pressed:
		if upgrade_resource:
			print("Applying upgrade: ", upgrade_resource.card_title)
			PlayerProperties.apply_upgrade(upgrade_resource)
			#Events.upgrade_applied.emit(upgrade_resource)
		else:
			printerr("No upgrade resource set for this card.")
