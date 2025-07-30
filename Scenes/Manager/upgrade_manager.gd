extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var exp_manager: Node
@export var upgrade_scene: PackedScene
var current_upgrades = {}


func _ready() -> void:
	exp_manager.level_up.connect(on_level_up)


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


func pick_upgrades():
	var choosen_upgrades: Array[AbilityUpgrade] = []
	var filtered_upgrades = upgrade_pool.duplicate()
	for i in 2:
		var choosen_upgrade = filtered_upgrades.pick_random() as AbilityUpgrade
		choosen_upgrades.append(choosen_upgrade)
		filtered_upgrades = filtered_upgrades.filter(func (upgrade): return upgrade.id != choosen_upgrade.id)
	
	return choosen_upgrades


func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)


func on_level_up(level: int):
	var upgrade_instance = upgrade_scene.instantiate()
	add_child(upgrade_instance)
	var choosen_upgrades = pick_upgrades()
	upgrade_instance.set_ability_upgrades(choosen_upgrades as Array[AbilityUpgrade])
	upgrade_instance.upgrade_selected.connect(on_upgrade_selected)
