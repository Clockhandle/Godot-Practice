extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var exp_manager: Node
@export var upgrade_scene: PackedScene
var current_upgrades = {}


func _ready() -> void:
	exp_manager.level_up.connect(on_level_up)
	


func on_level_up(level: int):
	var choosen_upgrade = upgrade_pool.pick_random() as AbilityUpgrade
	if (choosen_upgrade == null):
		return
	
	var upgrade_instance = upgrade_scene.instantiate()
	add_child(upgrade_instance)
	upgrade_instance.set_ability_upgrades([choosen_upgrade] as Array[AbilityUpgrade])
	upgrade_instance.upgrade_selected.connect(on_upgrade_selected)


func apply_upgrade(upgrade: AbilityUpgrade):
	var has_upgrade = current_upgrades.has(upgrade.id)
	if(!has_upgrade):
		current_upgrades[upgrade.id] = {
			"resources": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)
	print(current_upgrades)

func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)
