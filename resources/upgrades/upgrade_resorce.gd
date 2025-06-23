extends Resource
class_name UpgradeResource

enum UpgradeType {
    NONE,
    DAMAGE,
    HEALTH,
    SPEED,
    ATTACK_SPEED,
    CRITIC_DAMAGE,
}

@export var card_title: String
@export var card_description: String
@export var card_icon: Texture2D
@export var upgrade_type: UpgradeType = UpgradeType.NONE
@export var upgrade_value: float = 0.0