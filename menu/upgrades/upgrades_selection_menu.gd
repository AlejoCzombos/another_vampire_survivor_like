class_name UpgradesSelectionMenu
extends Control

@export var upgrades_resources: Array[UpgradeResource] = []

@onready var upgrade_card_scene: PackedScene = preload("res://menu/upgrades/upgrade_card.tscn")
@onready var cards_container: VFlowContainer = $CenterContainer/CardsContainer

var upgrade_cards: Array[UpgradeCard] = []

func _ready() -> void:
	for child: UpgradeCard in cards_container.get_children():
		cards_container.remove_child(child)
		child.queue_free()
	upgrade_cards.clear()

	randomize()
	#refresh_upgrade_cards()

func refresh_upgrade_cards() -> void:
	var selected_upgrades: Array[UpgradeResource] = get_random_upgrades(3)

	for upgrade: UpgradeResource in selected_upgrades:
		var card: UpgradeCard = upgrade_card_scene.instantiate() as UpgradeCard
		cards_container.add_child(card)
		card.set_upgrade(upgrade)
		upgrade_cards.append(card)

	show_upgrade_cards()

func get_random_upgrades(count: int) -> Array[UpgradeResource]:
	var available_upgrades: Array[UpgradeResource] = upgrades_resources.duplicate()
	var selected_upgrades: Array[UpgradeResource] = []

	for i: int in range(count):
		if available_upgrades.is_empty():
			break
		var random_index: int = randi() % available_upgrades.size()
		selected_upgrades.append(available_upgrades[random_index])
		available_upgrades.remove_at(random_index)

	return selected_upgrades

func show_upgrade_cards() -> void:
	for i: int in range(upgrade_cards.size()):
		upgrade_cards[i].play_entrance(i * 0.1)

func clear_upgrade_cards() -> void:
	for card: UpgradeCard in upgrade_cards:
		cards_container.remove_child(card)
		card.queue_free()
	upgrade_cards.clear()